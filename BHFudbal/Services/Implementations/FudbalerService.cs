using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Helpers;
using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using Microsoft.ML.Trainers.Recommender;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using Fudbaler = BHFudbal.BHFudbalDatabase.Fudbaler;
using Korisnik = BHFudbal.BHFudbalDatabase.Korisnik;

namespace BHFudbal.Services.Implementations
{
    public class FudbalerService : BaseCRUDService<Model.Fudbaler, FudbalerSearchObject, BHFudbalDatabase.Fudbaler, FudbalerInsertRequest, FudbalerUpdateRequest>, IFudbalerService
    {
        public FudbalerService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        { }

        public override Model.Fudbaler Insert(FudbalerInsertRequest request)
        {
            try
            {
                if (ImageValidator.IsJpeg(request.Slika) || ImageValidator.IsPng(request.Slika))
                {
                    var set = Context.Set<BHFudbalDatabase.Fudbaler>();
                    BHFudbalDatabase.Fudbaler entity = _mapper.Map<BHFudbalDatabase.Fudbaler>(request);
                    set.Add(entity);
                    Context.SaveChanges();
                    return _mapper.Map<Model.Fudbaler>(entity);
                }
                else
                {
                    throw new Exception("Error!");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public override IEnumerable<Model.Fudbaler> Get(FudbalerSearchObject search = null)
        {
            var entity = Context.Set<BHFudbalDatabase.Fudbaler>().AsQueryable();
            if (search.KlubId != 0)
            {
                entity = entity.Where(x => x.KlubId == search.KlubId);
            }

            entity = entity.Include(x => x.Klub).Include(x => x.Drzava);

            var model = _mapper.Map<List<Model.Fudbaler>>(entity);
            foreach (var x in model)
            {
                x.BrojGodina = CalculateAge(x.DatumRodjenja);
            }
            return model;
        }

        private int CalculateAge(DateTime birthdate)
        {
            DateTime currentDate = DateTime.Now;
            int age = currentDate.Year - birthdate.Year;

            // Check if the birthdate has occurred this year already
            if (currentDate.Month < birthdate.Month || (currentDate.Month == birthdate.Month && currentDate.Day < birthdate.Day))
            {
                age--;
            }

            return age;
        }

        public override Model.Fudbaler Update(int id, FudbalerUpdateRequest request)
        {
            var set = Context.Set<BHFudbalDatabase.Fudbaler>();
            var entity = set.Find(id);
            entity.Ime = request.Ime;
            entity.Prezime = request.Prezime;
            entity.Visina = request.Visina;
            entity.Težina = request.Težina;
            entity.JačaNoga = request.JačaNoga;
            entity.Slika = request.Slika;
            entity.DatumRodjenja = request.DatumRodjenja;
            Context.SaveChanges();
            return _mapper.Map<Model.Fudbaler>(entity);
        }

        public FudbalerDetails GetFudbaler(int fudbalerId)
        {
            var fudbalerContext = Context.Set<BHFudbalDatabase.Fudbaler>();
            var fudbaler = fudbalerContext.Include(x => x.Klub).FirstOrDefault(x => x.FudbalerId == fudbalerId);

            var matchContext = Context.Set<BHFudbalDatabase.Match>();
            var matches = matchContext.Include(x => x.Domacin).Include(x => x.Gost).Where(x => x.DomacinId == fudbaler.KlubId || x.GostId == fudbaler.KlubId).Select(x => new FudbalerMatchDetail()
            {
                MatchId = x.MatchId,
                Rezultat = $"{x.Domacin.Naziv} {x.Rezultat} {x.Gost.Naziv}"
            }).ToList();

            foreach (FudbalerMatchDetail matchDetail in matches)
            {
                var golContext = Context.Set<Gol>();
                var gols = golContext.Where(x => x.FudbalerId == fudbaler.FudbalerId && x.MatchId == matchDetail.MatchId).Count();
                matchDetail.Golovi = gols;

                var zutiKartonContext = Context.Set<ZutiKarton>();
                var zutiKartoni = zutiKartonContext.Where(x => x.FudbalerId == fudbaler.FudbalerId && x.MatchId == matchDetail.MatchId).Count();
                matchDetail.ZutiKartoni = zutiKartoni;

                var crveniKartonContext = Context.Set<CrveniKarton>();
                var crveniKartoni = crveniKartonContext.Where(x => x.FudbalerId == fudbaler.FudbalerId && x.MatchId == matchDetail.MatchId).Count();
                matchDetail.CrveniKartoni = crveniKartoni;
            }

            var fudbalerDetails = new FudbalerDetails()
            {
                ImePrezime = $"{fudbaler.Ime} {fudbaler.Prezime}",
                DatumRodjenja = fudbaler.DatumRodjenja.ToShortDateString(),
                JacaNoga = fudbaler.JačaNoga,
                Klub = fudbaler.Klub.Naziv,
                Tezina = fudbaler.Težina,
                Visina = fudbaler.Visina,
                Utakmice = matches
            };

            return fudbalerDetails;
        }

        public List<FudbalerHistorijaTransfera> GetFudbalerHistorijaTransfera(int fudbalerId)
        {
            var transferContent = Context.Set<BHFudbalDatabase.Transfer>();
            var transferi = transferContent.Where(x => x.FudbalerId == fudbalerId).Include(x => x.StariKlub).Include(x => x.Klub).Include(x => x.Fudbaler).Select(x => new FudbalerHistorijaTransfera
            {
                Cijena = x.Cijena.ToString(),
                ImeFudbalera = x.Fudbaler.Ime + " " + x.Fudbaler.Prezime,
                FudbalerId = x.FudbalerId,
                NoviKlub = x.Klub.Naziv,
                StariKlub = x.StariKlub.Naziv,
                Ugovor = x.BrojGodinaUgovora.ToString()
            }).ToList();

            return transferi;
        }

        public void DodajOmiljeniFudbaler(OmiljeniFudbalerInsertRequest request)
        {
            var fId = Context.Set<Fudbaler>().FirstOrDefault(x => x.FudbalerId == request.FudbalerId)?.FudbalerId;
            var kId = Context.Set<Korisnik>().FirstOrDefault(x => x.KorisnikId == request.KorisnikId)?.KorisnikId;

            if ((fId != 0 && fId != null) && (kId != 0 && kId != null))
            {
                var set = Context.Set<OmiljeniFudbaler>();

                var postojeci = set.FirstOrDefault(x => x.FudbalerId == request.FudbalerId && x.KorisnikId == request.KorisnikId);
                if (postojeci != null)
                {
                    postojeci.Rating = request.Rating;
                    Context.SaveChanges();
                }
                else
                {
                    var data = new OmiljeniFudbaler
                    {
                        FudbalerId = request.FudbalerId,
                        KorisnikId = request.KorisnikId,
                        Rating = request.Rating
                    };
                    set.Add(data);
                    Context.SaveChanges();
                }
            }
        }

        public void UkloniOmiljeniFudbaler(OmiljeniFudbalerInsertRequest request)
        {
            var omiljeniFudbaler = Context.Set<OmiljeniFudbaler>().FirstOrDefault(x => x.KorisnikId == request.KorisnikId && x.FudbalerId == request.FudbalerId);

            if (omiljeniFudbaler != null)
            {
                Context.Set<OmiljeniFudbaler>().Remove(omiljeniFudbaler);
                Context.SaveChanges();
            }
        }

        public int GetRating(int fudbalerId, int korisnikId)
        {
            var model = Context.Set<OmiljeniFudbaler>().FirstOrDefault(x => x.FudbalerId == fudbalerId && x.KorisnikId == korisnikId);

            if (model != null)
                return model.Rating;

            return 0;
        }
    }
}
