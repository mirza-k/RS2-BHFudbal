using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using Fudbaler = BHFudbal.BHFudbalDatabase.Fudbaler;

namespace BHFudbal.Services.Implementations
{
    public class KorisnikService : BaseCRUDService<Model.Korisnik, KorisnikSearchObject, BHFudbalDatabase.Korisnik, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService
    {
        private readonly IMessageProducer _messageProducer;
        public KorisnikService(BHFudbalDBContext context, IMapper mapper, IMessageProducer messageProducer) : base(context, mapper)
        {
            //_messageProducer = messageProducer;
        }

        public int Login(KorisnikInsertRequest login)
        {
            var query = Context.Set<BHFudbalDatabase.Korisnik>().Include(x => x.KorisničkiRačun).AsQueryable();

            if (!string.IsNullOrEmpty(login?.Username) && !string.IsNullOrEmpty(login?.Password))
            {
                if (login.AuthHandler)
                {
                    var korisnik = query.FirstOrDefault(x => login.Username == x.KorisničkiRačun.Username && login.Password == x.KorisničkiRačun.Password);
                    var result = korisnik?.KorisnikId != null ? korisnik.KorisnikId : 0;
                    return result;
                }
                else
                {
                    var adminUloga = Context.Set<Uloga>().FirstOrDefault(x => x.Naziv == "Admin");
                    var userUloga = Context.Set<Uloga>().FirstOrDefault(x => x.Naziv == "User");
                    var ulogaId = login.AdminPage ? adminUloga.UlogaId : userUloga.UlogaId;
                    var korisnik = query.FirstOrDefault(x => login.Username == x.KorisničkiRačun.Username && login.Password == x.KorisničkiRačun.Password &&
                    x.UlogaId == ulogaId);
                    var result = korisnik?.KorisnikId != null ? korisnik.KorisnikId : 0;
                //if (result != 0)
                //_messageProducer.SendingMessage<string>("Uspjesan login!");
                //else
                //_messageProducer.SendingMessage<string>("Doslo je do greske prilikom logiranja! Pokusajte ponovo.");
                    return result;
                }
            }

            return 0;
        }

        public bool Registracija(RegistracijaRequest registracijaRequest)
        {
            KorisničkiRačun korisničkiRačun = new KorisničkiRačun { Username = registracijaRequest.Username, Password = registracijaRequest.Password };
            try
            {
                var setKorisnickiRacun = Context.Set<KorisničkiRačun>();
                var provjera = setKorisnickiRacun.FirstOrDefault(x => x.Username == korisničkiRačun.Username);
                if (provjera != null)
                    return false;

                var racun = setKorisnickiRacun.Add(korisničkiRačun);
                Context.SaveChanges();

                registracijaRequest.KorisničkiRačunId = racun.Entity.KorisničkiRačunId;
                var newObj = _mapper.Map<BHFudbalDatabase.Korisnik>(registracijaRequest);
                var setKorisnik = Context.Set<BHFudbalDatabase.Korisnik>();
                setKorisnik.Add(newObj);
                Context.SaveChanges();

                return true;
            }
            catch (System.Exception)
            {
                //obrisi KorisnickiRacun u slucaju da se desi exception
                var setKorisnickiRacun = Context.Set<KorisničkiRačun>();
                setKorisnickiRacun.Remove(korisničkiRačun);
                Context.SaveChanges();
                return false;
            }

        }

        public override IEnumerable<Model.Korisnik> Get(KorisnikSearchObject search = null)
        {
            var entity = Context.Set<BHFudbalDatabase.Korisnik>().AsQueryable();

            if (search?.Ime != null)
            {
                entity = entity.Where(x => x.Ime.Contains(search.Ime));
            }

            entity = entity.Include(x => x.Grad).Include(x => x.KorisničkiRačun).Include(x => x.Uloga);

            return _mapper.Map<List<Model.Korisnik>>(entity);
        }

        public override Model.Korisnik GetById(int id)
        {
            var entity = Context.Set<BHFudbalDatabase.Korisnik>().AsQueryable();

            entity = entity.Where(x => x.KorisnikId == id);

            entity = entity.Include(x => x.Grad).Include(x => x.KorisničkiRačun).Include(x => x.Uloga);

            return _mapper.Map<Model.Korisnik>(entity.FirstOrDefault());
        }

        public int Uredi(UrediKorisnika request)
        {
            var set = Context.Set<BHFudbalDatabase.Korisnik>();
            var model = set.Include(x => x.KorisničkiRačun).FirstOrDefault(x => x.KorisnikId == request.KorisnikId);
            model.Ime = request.Ime;
            model.Prezime = request.Prezime;
            model.KorisničkiRačun.Username = request.Username;
            Context.SaveChanges();
            return 1;
        }

        public int UpdateToPremium(UpdateToPremiumRequest request)
        {
            var setKorisnickiRacun = Context.Set<KorisničkiRačun>();
            var korisnickiRacunId = setKorisnickiRacun.FirstOrDefault(x => x.Username == request.Username && x.Password == request.Password).KorisničkiRačunId;
            var setKorisnik = Context.Set<BHFudbalDatabase.Korisnik>();
            var korisnik = setKorisnik.FirstOrDefault(x => x.KorisničkiRačunId == korisnickiRacunId);
            korisnik.IsPremium = true;
            Context.SaveChanges();
            return 1;
        }

        public int IsKorisnikPremium(UpdateToPremiumRequest request)
        {
            var setKorisnickiRacun = Context.Set<KorisničkiRačun>();
            var korisnickiRacun = setKorisnickiRacun.FirstOrDefault(x => x.Username == request.Username && x.Password == request.Password);
            if (korisnickiRacun != null)
            {
                int korisnickiRacunId = korisnickiRacun.KorisničkiRačunId;
                var setKorisnik = Context.Set<BHFudbalDatabase.Korisnik>();
                var korisnik = setKorisnik.FirstOrDefault(x => x.KorisničkiRačunId == korisnickiRacunId);
                if (korisnik != null)
                {
                    if (korisnik.IsPremium)
                        return 1;
                    else
                        return 0;
                }
            }

            return 0;
        }

        public PremiumReport PremiumReport(int sezonaId)
        {
            var setTransfer = Context.Set<BHFudbalDatabase.Transfer>();
            var setKlub = Context.Set<BHFudbalDatabase.Klub>();
            var setMatch = Context.Set<BHFudbalDatabase.Match>();
            var kluboviIds = setKlub.Select(x => x.KlubId).ToList();
            List<FinancijskiRezultati> financijskiRezultati = new List<FinancijskiRezultati>();

            foreach (var id in kluboviIds)
            {
                var prodano = setTransfer.Where(x => x.StariKlubId == id && x.SezonaId == sezonaId).Count();
                var kupljeno = setTransfer.Where(x => x.KlubId == id && x.SezonaId == sezonaId).Count();
                var nazivKluba = setKlub.FirstOrDefault(x => x.KlubId == id).Naziv;
                var potroseniNovac = setTransfer.Where(x => x.KlubId == id && x.SezonaId == sezonaId).Sum(x => x.Cijena);
                var zaradjeniNovac = setTransfer.Where(x => x.StariKlubId == id && x.SezonaId == sezonaId).Sum(x => x.Cijena);

                financijskiRezultati.Add(new FinancijskiRezultati
                {
                    BrojKupljenihIgraca = kupljeno.ToString(),
                    BrojProdatihIgraca = prodano.ToString(),
                    Finansije = (zaradjeniNovac - potroseniNovac).ToString() + " KM",
                    NazivKluba = nazivKluba.ToString()
                });
            }

            List<KlubGoloviReport> klubGoloviReport = new List<KlubGoloviReport>();
            foreach (var id in kluboviIds)
            {
                var nazivKluba = setKlub.FirstOrDefault(x => x.KlubId == id).Naziv;
                var rezultatiKuci = setMatch.Include(x => x.Liga).Where(x => x.Liga.SezonaId == sezonaId && x.DomacinId == id).Select(x => x.Rezultat).ToList();
                int brojGolovaKuci = 0;
                foreach (var x in rezultatiKuci)
                {
                    var str = x.Split("-")[0];
                    var broj = int.Parse(str);
                    brojGolovaKuci += broj;
                }
                var rezultatiUGostima = setMatch.Include(x => x.Liga).Where(x => x.Liga.SezonaId == sezonaId && x.GostId == id).Select(x => x.Rezultat).ToList();
                int brojGolovaUGostima = 0;
                foreach (var x in rezultatiUGostima)
                {
                    var str = x.Split("-")[1];
                    var broj = int.Parse(str);
                    brojGolovaUGostima += broj;
                }
                klubGoloviReport.Add(new KlubGoloviReport
                {
                    BrojGolovaKuci = brojGolovaKuci.ToString(),
                    BrojGolovaUGostima = brojGolovaUGostima.ToString(),
                    Naziv = nazivKluba
                });
            }

            //prikaz strijelaca kroz sezonu po klubu
            List<KlubFudbalerSezonaReport> klubFudbalerSezonaReport = new List<KlubFudbalerSezonaReport>();
            foreach (var id in kluboviIds)
            {
                List<FudbalerReport> fudbalerReports = new List<FudbalerReport>();
                var nazivKluba = setKlub.FirstOrDefault(x => x.KlubId == id).Naziv;
                var setGols = Context.Set<Gol>();
                var setFudbaler = Context.Set<Fudbaler>();
                var setZuti = Context.Set<ZutiKarton>();
                var setCrveni = Context.Set<CrveniKarton>();
                var setLiga = Context.Set<LigaId>();

                var queryGols = from g in setGols
                                join f in setFudbaler on g.FudbalerId equals f.FudbalerId
                                join m in setMatch on g.MatchId equals m.MatchId
                                join l in setLiga on m.LigaId equals l.LigaId1
                                where f.KlubId == id && l.SezonaId == sezonaId
                                group f by new { f.FudbalerId, f.Ime, f.Prezime } into grouped
                                select new
                                {
                                    FudbalerId = grouped.Key.FudbalerId,
                                    Ime = grouped.Key.Ime,
                                    Prezime = grouped.Key.Prezime,
                                    GoloviCount = grouped.Count()
                                };
                //queryGols = queryGols.OrderByDescending(x => x.Count);

                var queryZutiKarton = from zk in setZuti
                                      join f in setFudbaler on zk.FudbalerId equals f.FudbalerId
                                      join m in setMatch on zk.MatchId equals m.MatchId
                                      join l in setLiga on m.LigaId equals l.LigaId1
                                      where f.KlubId == id && l.SezonaId == sezonaId
                                      group f by new { f.FudbalerId, f.Ime, f.Prezime } into grouped
                                      select new
                                      {
                                          FudbalerId = grouped.Key.FudbalerId,
                                          Ime = grouped.Key.Ime,
                                          Prezime = grouped.Key.Prezime,
                                          ZutiCount = grouped.Count()
                                      };
                var queryCrveniKartons = from ck in setCrveni
                                         join f in setFudbaler on ck.FudbalerId equals f.FudbalerId
                                         join m in setMatch on ck.MatchId equals m.MatchId
                                         join l in setLiga on m.LigaId equals l.LigaId1
                                         where f.KlubId == id && l.SezonaId == sezonaId
                                         group f by new { f.FudbalerId, f.Ime, f.Prezime } into grouped
                                         select new
                                         {
                                             FudbalerId = grouped.Key.FudbalerId,
                                             Ime = grouped.Key.Ime,
                                             Prezime = grouped.Key.Prezime,
                                             CrveniCount = grouped.Count()
                                         };
                var fudbalerIds = setFudbaler.Where(x => x.KlubId == id).Select(x => x.FudbalerId).ToList();
                foreach (var fudbalerId in fudbalerIds)
                {
                    var fudbaler = setFudbaler.FirstOrDefault(x => x.FudbalerId == fudbalerId);
                    var imePrezime = fudbaler.Ime + " " + fudbaler.Prezime;
                    var brojGolova = queryGols.FirstOrDefault(x => x.FudbalerId == fudbalerId)?.GoloviCount ?? 0;
                    var brojZutih = queryZutiKarton.FirstOrDefault(x => x.FudbalerId == fudbalerId)?.ZutiCount ?? 0;
                    var brojCrvenih = queryCrveniKartons.FirstOrDefault(x => x.FudbalerId == fudbalerId)?.CrveniCount ?? 0;
                    fudbalerReports.Add(new FudbalerReport { ImeFudbalera = imePrezime, BrojGolova = brojGolova.ToString(), BrojCrvenih = brojCrvenih.ToString(), BrojZutih = brojZutih.ToString() });
                }
                klubFudbalerSezonaReport.Add(new KlubFudbalerSezonaReport { NazivKluba = nazivKluba, FudbalerReport = fudbalerReports });
            }


            var res = new PremiumReport { FinancijskiRezultati = financijskiRezultati, KlubGoloviReport = klubGoloviReport, KlubFudbalerSezonaReport = klubFudbalerSezonaReport };
            return res;
        }

    }
}
