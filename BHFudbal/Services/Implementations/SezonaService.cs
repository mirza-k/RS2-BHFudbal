using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Flurl.Util;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BHFudbal.Services.Implementations
{
    public class SezonaService : BaseCRUDService<Model.Sezona, SezonaSearchObject, Sezona, SezonaInsertRequest, SezonaUpdateRequest>, ISezonaService
    {
        private readonly IMatchService _matchService;
        public SezonaService(BHFudbalDBContext context, IMapper mapper, IMatchService matchService) : base(context, mapper)
        {
            _matchService = matchService;
        }

        public override IEnumerable<Model.Sezona> Get(SezonaSearchObject search = null)
        {
            var entity = Context.Set<Sezona>().AsQueryable();

            return _mapper.Map<List<Model.Sezona>>(entity);
        }

        public string GenerisiSezonu()
        {
            var provjera = ProvjeriBrojKlubovaULigama();

            if (provjera != "")
                return provjera;

            var ligaEntity = Context.Set<LigaId>();
            var klubEntity = Context.Set<Klub>();

            // posljednoplasirani klub relegiraj a prvoplasirani klub promovisi
            var prvaLiga = ligaEntity.Include(x => x.Sezona).FirstOrDefault(x => x.Naziv.Contains("Premier") && x.Sezona.Aktivna == true);
            var drugaLiga = ligaEntity.Include(x => x.Sezona).FirstOrDefault(x => x.Naziv.Contains("Druga") && x.Sezona.Aktivna == true);

            var prvaLigaTabela = _matchService.GetTabelaByLigaId(prvaLiga.LigaId1);
            var prvaLigaPosljednji = prvaLigaTabela[prvaLigaTabela.Count() - 1];
            var drugaLigaTabela = _matchService.GetTabelaByLigaId(drugaLiga.LigaId1);
            var drugaLigaPrvi = drugaLigaTabela[0];

            //dodaj novu sezonu i ucini je trenutnom
            var sezonaEntity = Context.Set<Sezona>().AsQueryable();
            var trenutnaSezona = sezonaEntity.FirstOrDefault(x => x.Aktivna);
            trenutnaSezona.Aktivna = false;
            string[] parts = trenutnaSezona.Naziv.Split('/');
            int prviDio = int.Parse(parts[0]);
            int drugiDio = int.Parse(parts[1]);
            string novaSezona = drugiDio.ToString() + '/' + (++drugiDio).ToString();
            var modelSezona = new Sezona
            {
                Aktivna = true,
                Naziv = novaSezona
            };
            Context.Set<Sezona>().Add(modelSezona);
            Context.SaveChanges();

            //generisi novu ligu
            var novaPremierLiga = new LigaId
            {
                Naziv = "Premier Liga" + " - " + modelSezona.Naziv,
                SezonaId = modelSezona.SezonaId
            };
            var novaDrugaLiga = new LigaId
            {
                Naziv = "Druga Liga" + " - " + modelSezona.Naziv,
                SezonaId = modelSezona.SezonaId
            };
            ligaEntity.Add(novaPremierLiga);
            ligaEntity.Add(novaDrugaLiga);
            Context.SaveChanges();

            UpdateKluboveNovomLigom(novaPremierLiga, novaDrugaLiga, drugaLigaPrvi.NazivKluba, prvaLigaPosljednji.NazivKluba);

            //generisi matcheve premier lige
            //provjeri da li klub ima igrace, ako nema, ne moze imati utakmice
            var premierLigaKlubovi = klubEntity.Include(x => x.Fudbalers).Where(x => x.LigaId == novaPremierLiga.LigaId1 && x.Fudbalers.Count() > 0).Select(x => x.KlubId).ToList();
            var raspored = GenerisiRaspored(premierLigaKlubovi);
            foreach(var ras in raspored)
            {
                GenerisiMatch(ras.Item1, ras.Item2, ras.Item3, novaPremierLiga.LigaId1);
            }

            //generisi matcheve druge lige
            //provjeri da li klub ima igrace, ako nema, ne moze imati utakmice
            var drugaLigaKlubovi = klubEntity.Include(x => x.Fudbalers).Where(x => x.LigaId == novaDrugaLiga.LigaId1 && x.Fudbalers.Count() > 0).Select(x => x.KlubId).ToList();
            raspored = GenerisiRaspored(drugaLigaKlubovi);
            foreach (var ras in raspored)
            {
                GenerisiMatch(ras.Item1, ras.Item2, ras.Item3, novaDrugaLiga.LigaId1);
            }

            Context.SaveChanges();
            return "";
        }

        public string ProvjeriBrojKlubovaULigama()
        {
            var ligaEntity = Context.Set<LigaId>();
            var klubEntity = Context.Set<Klub>();

            //provjeri je li paran broj klubova u prvoj ligi
            var prvaLiga = ligaEntity.Include(x => x.Sezona).FirstOrDefault(x => x.Naziv.Contains("Premier") && x.Sezona.Aktivna == true);
            var brojklubova = klubEntity.Where(x => x.LigaId == prvaLiga.LigaId1).Count();
            if (brojklubova % 2 != 0)
                return "Broj klubova u Premier Ligi neparan! Da bi generisali novu sezonu broj klubova mora biti paran.";

            //provjeri je li paran broj klubova u drugoj ligi
            var drugaLiga = ligaEntity.Include(x => x.Sezona).FirstOrDefault(x => x.Naziv.Contains("Druga") && x.Sezona.Aktivna == true);
            brojklubova = klubEntity.Where(x => x.LigaId == drugaLiga.LigaId1).Count();
            if (brojklubova % 2 != 0)
                return "Broj klubova u Drugoj Ligi neparan! Da bi generisali novu sezonu broj klubova mora biti paran.";

            return "";
        }

        public List<Tuple<int, int, int>> GenerisiRaspored(List<int> klubIds)
        {
            List<Tuple<int, int, int>> fixtures = new List<Tuple<int, int, int>>();

            int totalRounds = 2 * (klubIds.Count - 1);

            for (int round = 0; round < totalRounds; round++)
            {
                for (int i = 0; i < klubIds.Count / 2; i++)
                {
                    int team1 = klubIds[i];
                    int team2 = klubIds[klubIds.Count - 1 - i];

                    var brojKola = round;
                    if (round % 2 == 0)
                    {
                        // parna runda: team 1 igra kuci
                        fixtures.Add(new Tuple<int, int, int>(team1, team2, ++brojKola));
                    }
                    else
                    {
                        // neparna runda: team 1 igra u gostima
                        fixtures.Add(new Tuple<int, int, int>(team2, team1, ++brojKola));
                    }
                }
                // Rotiraj timove za sljedecu rundu
                klubIds.Insert(1, klubIds[klubIds.Count - 1]);
                klubIds.RemoveAt(klubIds.Count - 1);
            }

            return fixtures;
        }

        private void UpdateKluboveNovomLigom(LigaId trenutnaPremierLiga, LigaId trenutnaDrugaLiga, string promovisaniKlub, string ispadajuciKlub)
        {
            var klubEntity = Context.Set<Klub>();
            var prvaLigaKlubovi = klubEntity.Where(x => x.Liga.Naziv.Contains("Premier")).Include(x => x.Liga).ToList();
            var drugaLigaKlubovi = klubEntity.Where(x => x.Liga.Naziv.Contains("Druga")).Include(x => x.Liga).ToList();

            foreach (var klub in prvaLigaKlubovi)
            {
                klub.LigaId = trenutnaPremierLiga.LigaId1;
            }

            foreach (var klub in drugaLigaKlubovi)
            {
                klub.LigaId = trenutnaDrugaLiga.LigaId1;
            }

            klubEntity.FirstOrDefault(x => x.Naziv == promovisaniKlub).LigaId = trenutnaPremierLiga.LigaId1;
            klubEntity.FirstOrDefault(x => x.Naziv == ispadajuciKlub).LigaId = trenutnaDrugaLiga.LigaId1;
            Context.SaveChanges();
        }

        private void GenerisiMatch(int domaciId, int gostiId, int brojKola, int ligaId)
        {
                var domaciGol = GetRandomRezultat();
                var gostiGol = GetRandomRezultat();
                var domacaEkipa = domaciId;
                var gostujucaEkipa = gostiId;
                var rez = domaciGol + " - " + gostiGol;
                int? pobjednik;
                if (domaciGol == gostiGol)
                    pobjednik = null;
                else
                    pobjednik = domaciGol > gostiGol ? domacaEkipa : gostujucaEkipa;

                var match = new Match
                {
                    Datum = System.DateTime.Now,
                    Stadion = "Stadion",
                    DomacinId = domacaEkipa,
                    GostId = gostujucaEkipa,
                    Rezultat = rez,
                    Pobjednik = pobjednik,
                    LigaId = ligaId,
                    RedniBrojKola = brojKola
                };
                Context.Set<Match>().Add(match);
                Context.SaveChanges();

                GenerisiGolove(domaciId, gostiId, domaciGol, gostiGol, match.MatchId);
                GenerisiZute(domaciId, gostiId, match.MatchId);
                GenerisiCrvene(domaciId, gostiId, match.MatchId);
        }

        private void GenerisiGolove(int domaciId, int gostiId, int domaciGolovi, int gostiGolovi, int matchId)
        {
            var golEntity = Context.Set<Gol>();
            Random rand = new Random();

            var domaciFudbaleri = Context.Set<Fudbaler>().Where(x => x.KlubId == domaciId).Select(x => x.FudbalerId).ToList();
            var gostujuciFudbaleri = Context.Set<Fudbaler>().Where(x => x.KlubId == gostiId).Select(x => x.FudbalerId).ToList();

            for (int i = 0; i < domaciGolovi; i++)
            {
                var minutaGola = rand.Next(1, 90);
                int randomIndex = rand.Next(0, domaciFudbaleri.Count() - 1);
                var gol = new Gol
                {
                    MatchId = matchId,
                    MinutaGola = minutaGola,
                    FudbalerId = domaciFudbaleri[randomIndex]
                };
                golEntity.Add(gol);
            }

            for (int i = 0; i < gostiGolovi; i++)
            {
                var minutaGola = rand.Next(1, 90);
                int randomIndex = rand.Next(0, gostujuciFudbaleri.Count() - 1);
                var gol = new Gol
                {
                    MatchId = matchId,
                    MinutaGola = minutaGola,
                    FudbalerId = gostujuciFudbaleri[randomIndex]
                };
                golEntity.Add(gol);
            }
            Context.SaveChanges();
        }

        private void GenerisiZute(int domaciId, int gostiId, int matchId)
        {
            var zutiEntity = Context.Set<ZutiKarton>();
            Random rand = new Random();

            int domaciKartoni = rand.Next(0, 2);
            var domaciFudbaleri = Context.Set<Fudbaler>().Where(x => x.KlubId == domaciId).Select(x => x.FudbalerId).ToList();
            var gostujuciFudbaleri = Context.Set<Fudbaler>().Where(x => x.KlubId == gostiId).Select(x => x.FudbalerId).ToList();

            for (int i = 0; i < domaciKartoni; i++)
            {
                var minuta = rand.Next(1, 90);
                int randomIndex = rand.Next(0, domaciFudbaleri.Count() - 1);
                var zuti = new ZutiKarton
                {
                    MatchId = matchId,
                    MinutaKartona = minuta,
                    FudbalerId = domaciFudbaleri[randomIndex]
                };
                zutiEntity.Add(zuti);
            }

            int gostiKartoni = rand.Next(0, 2);
            for (int i = 0; i < gostiKartoni; i++)
            {
                var minutaGola = rand.Next(1, 90);
                int randomIndex = rand.Next(0, gostujuciFudbaleri.Count() - 1);
                var karton = new ZutiKarton
                {
                    MatchId = matchId,
                    MinutaKartona = minutaGola,
                    FudbalerId = gostujuciFudbaleri[randomIndex]
                };
                zutiEntity.Add(karton);
            }
            Context.SaveChanges();
        }

        private void GenerisiCrvene(int domaciId, int gostiId, int matchId)
        {
            var crveniEntity = Context.Set<CrveniKarton>();
            Random rand = new Random();

            int domaciKartoni = rand.Next(0, 1);
            var domaciFudbaleri = Context.Set<Fudbaler>().Where(x => x.KlubId == domaciId).Select(x => x.FudbalerId).ToList();
            var gostujuciFudbaleri = Context.Set<Fudbaler>().Where(x => x.KlubId == gostiId).Select(x => x.FudbalerId).ToList();

            for (int i = 0; i < domaciKartoni; i++)
            {
                var minuta = rand.Next(1, 90);
                int randomIndex = rand.Next(0, domaciFudbaleri.Count() - 1);
                var crveniKarton = new CrveniKarton
                {
                    MatchId = matchId,
                    MinutaKartona = minuta,
                    FudbalerId = domaciFudbaleri[randomIndex]
                };
                crveniEntity.Add(crveniKarton);
            }

            int gostiKartoni = rand.Next(0, 2);
            for (int i = 0; i < gostiKartoni; i++)
            {
                var minutaGola = rand.Next(1, 90);
                int randomIndex = rand.Next(0, gostujuciFudbaleri.Count() - 1);
                var crveni = new CrveniKarton
                {
                    MatchId = matchId,
                    MinutaKartona = minutaGola,
                    FudbalerId = gostujuciFudbaleri[randomIndex]
                };
                crveniEntity.Add(crveni);
            }
            Context.SaveChanges();
        }

        private int GetRandomRezultat()
        {
            Random rand = new Random();
            return rand.Next(0, 3); // Change the range as needed for your application.
        }

        private int GenerisiBrojKola(int domacinId, int gostId, List<Match> matches, int ligaId, int maxBrojKola)
        {
            var kola = matches.Where(x => (x.DomacinId == domacinId || x.DomacinId == gostId) || (x.GostId == domacinId || x.GostId == gostId)).Select(x => x.RedniBrojKola);
            kola = kola.OrderBy(x => x);
            for (int i = 1; i <= maxBrojKola; i++)
            {
                if (!kola.Contains(i))
                    return i;
            }
            return 0;
        }
    }
}
