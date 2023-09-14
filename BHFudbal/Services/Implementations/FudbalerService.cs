using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace BHFudbal.Services.Implementations
{
    public class FudbalerService : BaseCRUDService<Model.Fudbaler, FudbalerSearchObject, BHFudbalDatabase.Fudbaler, FudbalerInsertRequest, FudbalerUpdateRequest>, IFudbalerService
    {
        public FudbalerService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        { }

        public override IEnumerable<Model.Fudbaler> Get(FudbalerSearchObject search = null)
        {
            var entity = Context.Set<BHFudbalDatabase.Fudbaler>().AsQueryable();
            if (search.KlubId != 0)
            {
                entity = entity.Where(x => x.KlubId == search.KlubId);
            }

            entity = entity.Include(x => x.Klub).Include(x => x.Drzava);

            return _mapper.Map<List<Model.Fudbaler>>(entity);
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
            var fudbaler = fudbalerContext.Include(x=>x.Klub).FirstOrDefault(x => x.FudbalerId == fudbalerId);

            var matchContext = Context.Set<BHFudbalDatabase.Match>();
            var matches = matchContext.Include(x => x.Domacin).Include(x => x.Gost).Where(x => x.DomacinId == fudbaler.KlubId || x.GostId == fudbaler.KlubId).Select(x => new FudbalerMatchDetail()
            {
                MatchId = x.MatchId,
                Rezultat = $"{x.Domacin.Naziv} {x.Rezultat} {x.Gost.Naziv}"
            }).ToList();

            foreach(FudbalerMatchDetail matchDetail in matches)
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
    }
}
