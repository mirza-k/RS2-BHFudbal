using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Helpers;
using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileSystemGlobbing.Internal;
using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.Linq;
using Klub = BHFudbal.BHFudbalDatabase.Klub;
using Match = BHFudbal.BHFudbalDatabase.Match;

namespace BHFudbal.Services.Implementations
{
    public class MatchService : BaseCRUDService<Model.Match, FudbalerSearchObject, BHFudbalDatabase.Match, MatchInsertRequest, MatchUpdateRequest>, IMatchService
    {
        public MatchService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public IEnumerable<Model.Match> Get(MatchSearchObject search = null)
        {
            var entity = Context.Set<Match>().AsQueryable();
            if (search?.LigaId != null)
            {
                entity = entity.Where(x => x.LigaId == search.LigaId).OrderBy(x => x.RedniBrojKola);
            }
            if (search?.RedniBrojKola != null && search?.RedniBrojKola != 0)
            {
                entity = entity.Where(x => x.RedniBrojKola == search.RedniBrojKola);
            }

            entity = entity.Include(x => x.Gost).Include(x => x.Domacin);

            var models = entity.Select(x => new Model.Match
            {
                LigaId = x.LigaId,
                DomacinId = x.DomacinId,
                GostId = x.GostId,
                MatchId = x.MatchId,
                RedniBrojKola = x.RedniBrojKola,
                Prikaz = search.AdminPage ? x.RedniBrojKola + ". kolo    " + x.Domacin.Naziv + "  " + x.Rezultat + "  " + x.Gost.Naziv : x.Domacin.Naziv + "  " + x.Rezultat + "  " + x.Gost.Naziv
            });

            return _mapper.Map<List<Model.Match>>(models);
        }

        public MatchDetails GetDetails(int matchId)
        {
            MatchDetails matchDetails = new MatchDetails();
            var matchEntity = Context.Set<Match>();
            var matchObject = matchEntity.FirstOrDefault(x => x.MatchId == matchId);
            matchDetails.MatchId = matchObject.MatchId;
            matchDetails.Rezultat = matchObject.Rezultat;

            var golEntity = Context.Set<Gol>();
            var golObjects = golEntity.Where(x => x.MatchId == matchId).Include(x => x.Fudbaler).OrderBy(x => x.MinutaGola).ToList();
            List<GolDetails> golDetails = golObjects.Select(x => new GolDetails
            {
                ImeFudbalera = x.Fudbaler.Ime + " " + x.Fudbaler.Prezime,
                KlubId = x.Fudbaler.KlubId,
                MinutaGola = x.MinutaGola,
                Domacin = x.Fudbaler.KlubId == matchObject.DomacinId
            }).ToList();
            matchDetails.GolDetails = golDetails;

            var zutiKartonEntity = Context.Set<ZutiKarton>();
            var zutiKartonObjects = zutiKartonEntity.Where(x => x.MatchId == matchId).Include(x => x.Fudbaler).OrderBy(x => x.MinutaKartona).ToList();
            List<ZutiKartonDetails> zutiKartonDetails = zutiKartonObjects.Select(x => new ZutiKartonDetails
            {
                ImeFudbalera = x.Fudbaler.Ime + " " + x.Fudbaler.Prezime,
                KlubId = x.Fudbaler.KlubId,
                MinutaKartona = x.MinutaKartona,
                Domacin = x.Fudbaler.KlubId == matchObject.DomacinId
            }).ToList();
            matchDetails.ZutiKartonDetails = zutiKartonDetails;

            var crveniKartonEntity = Context.Set<CrveniKarton>();
            var crveniKartonObjects = crveniKartonEntity.Where(x => x.MatchId == matchId).Include(x => x.Fudbaler).OrderBy(x => x.MinutaKartona).ToList();
            List<CrveniKartonDetails> crveniKartonDetails = crveniKartonObjects.Select(x => new CrveniKartonDetails
            {
                ImeFudbalera = x.Fudbaler.Ime + " " + x.Fudbaler.Prezime,
                KlubId = x.Fudbaler.KlubId,
                MinutaKartona = x.MinutaKartona,
                Domacin = x.Fudbaler.KlubId == matchObject.DomacinId
            }).ToList();
            matchDetails.CrveniKartonDetails = crveniKartonDetails;

            var klubEntity = Context.Set<Klub>();
            var domaci = klubEntity.Include(x => x.Fudbalers).FirstOrDefault(x => x.KlubId == matchObject.DomacinId);
            var gosti = klubEntity.Include(x => x.Fudbalers).FirstOrDefault(x => x.KlubId == matchObject.GostId);
            matchDetails.PostaveDomaci = domaci.Fudbalers.Select(x => x.Ime + " " + x.Prezime).ToList();
            matchDetails.Domaci = domaci.Naziv;
            matchDetails.DomaciSlika = domaci.Grb;
            matchDetails.PostaveGosti = gosti.Fudbalers.Select(x => x.Ime + " " + x.Prezime).ToList();
            matchDetails.Gosti = gosti.Naziv;
            matchDetails.GostiSlika = gosti.Grb;
            return matchDetails;
        }

        public List<Tabela> GetTabelaByLigaId(int ligaId)
        {
            var matchContext = Context.Set<Match>();
            var matchesByLigaId = matchContext.Where(x => x.LigaId == ligaId).ToList();
            var klubIds = matchesByLigaId.Select(x => x.DomacinId).Distinct().ToList();

            List<Tabela> tabela = new List<Tabela>();

            foreach (var klubId in klubIds)
            {
                //samo ako klub nije tek dodan, uzmi u obzir njega u tabeli
                Match imaMatcheva = matchContext.FirstOrDefault(x => (x.DomacinId == klubId || x.GostId == klubId) && x.LigaId == ligaId);
                if (imaMatcheva != null)
                {
                    int brojUtakmica = matchesByLigaId.Where(x => x.DomacinId == klubId || x.GostId == klubId).Count();
                    int brojPobjeda = matchesByLigaId.Where(x => x.Pobjednik == klubId).Count();
                    int brojNerjesenih = matchesByLigaId.Where(x => x.Pobjednik == null && (x.DomacinId == klubId || x.GostId == klubId)).Count();
                    int brojPoraza = brojUtakmica - (brojPobjeda + brojNerjesenih);

                    int brojBodova = (brojPobjeda * 3) + brojNerjesenih;
                    int brojKola = GetMaxBrojKola(ligaId);
                    var nazivKluba = Context.Set<Klub>().FirstOrDefault(x => x.KlubId == klubId)?.Naziv;
                    tabela.Add(new Tabela(nazivKluba, brojBodova, brojKola));
                }
            }

            tabela = tabela.OrderByDescending(x => x.BrojBodova).ToList();

            return tabela;
        }

        public MatchesByKlubId GetMatchesByKlubIds(int klubId, int? sezonaId)
        {
            var matchContext = Context.Set<Match>();
            if (sezonaId == null || sezonaId == 0)
            {
                var matches = matchContext.Include(x => x.Liga).ThenInclude(x => x.Sezona).Where(x => (x.DomacinId == klubId || x.GostId == klubId) && x.Liga.Sezona.Aktivna == true);
                return CalculateMatchesByKlubId(matches, klubId);
            }
            else
            {
                var matches = matchContext.Include(x => x.Liga).ThenInclude(x => x.Sezona).Where(x => (x.DomacinId == klubId || x.GostId == klubId) && x.Liga.Sezona.SezonaId == sezonaId);
                return CalculateMatchesByKlubId(matches, klubId);
            }
        }

        private MatchesByKlubId CalculateMatchesByKlubId(IQueryable<Match> matches, int klubId)
        {
            int brojDatihGolova = 0;
            int brojPrimljenihGolova = 0;
            foreach (var match in matches)
            {
                if (match.DomacinId == klubId)
                {
                    if (char.IsDigit(match.Rezultat[0]))
                    {
                        brojDatihGolova += (int)Char.GetNumericValue(match.Rezultat[0]);
                    }

                    if (char.IsDigit(match.Rezultat[match.Rezultat.Length - 1]))
                    {
                        brojPrimljenihGolova += (int)Char.GetNumericValue(match.Rezultat[match.Rezultat.Length - 1]);
                    }
                }
                else
                {
                    if (char.IsDigit(match.Rezultat[0]))
                    {
                        brojDatihGolova += (int)Char.GetNumericValue(match.Rezultat[match.Rezultat.Length - 1]);
                    }

                    if (char.IsDigit(match.Rezultat[match.Rezultat.Length - 1]))
                    {
                        brojPrimljenihGolova += (int)Char.GetNumericValue(match.Rezultat[0]);
                    }
                }
            }

            List<string> rezultati = matches.Include(x => x.Domacin).Include(x => x.Gost).OrderBy(x => x.RedniBrojKola).Select(x => x.RedniBrojKola + ".kolo" + "   " + x.Domacin.Naziv + "   " + x.Rezultat + "   " + x.Gost.Naziv).ToList();
            MatchesByKlubId matchesByKlubId = new MatchesByKlubId() { BrojDatihGolova = brojDatihGolova, BrojPrimljenihGolova = brojPrimljenihGolova, Rezultati = rezultati };
            return matchesByKlubId;
        }

        public List<PrikazStrijelaca> GetStrijelciByLigaId(int ligaId)
        {
            var matchContext = Context.Set<Match>();
            var matchesByLigaId = matchContext.Where(x => x.LigaId == ligaId).Select(x => x.MatchId).ToList();

            var test = Context.Set<Gol>().Include(x => x.Match).Include(x => x.Fudbaler).Where(x => matchesByLigaId.Contains(x.MatchId)).GroupBy(g => g.Fudbaler.Ime + " " + g.Fudbaler.Prezime).Select(g => new { Fudbaler = g.Key, GolCount = g.Count() }).OrderByDescending(x => x.GolCount).ToList();

            var fudbalerEntity = Context.Set<Gol>();
            var fudbalerGoalCounts = fudbalerEntity.Include(x => x.Fudbaler).ThenInclude(x => x.Klub).Where(x => x.Fudbaler.Klub.LigaId == ligaId).GroupBy(g => g.Fudbaler.Ime + " " + g.Fudbaler.Prezime).Select(g => new { Fudbaler = g.Key, GolCount = g.Count() }).OrderByDescending(x => x.GolCount).ToList();

            var result = test.Select(x => new PrikazStrijelaca() { BrojGolova = x.GolCount, NazivFudbalera = x.Fudbaler }).ToList();
            return result;
        }

        public List<FormaView> GetForma(int ligaId)
        {
            var matchEntity = Context.Set<Match>();
            var klubEntity = Context.Set<Klub>();

            var matchesByLigaId = Context.Set<Match>().Include(x => x.Domacin).Where(x => x.LigaId == ligaId).ToList();
            var klubs = matchesByLigaId.Select(x=>x.Domacin).Distinct().ToList();

            //var klubovi = klubEntity.Where(x => x.LigaId == ligaId).ToList();
            //var matches = matchEntity.Where(x => x.LigaId == ligaId);
            List<FormaView> formaView = new List<FormaView>();
            foreach (var klub in klubs)
            {
                var forma = matchesByLigaId.Where(x => x.DomacinId == klub.KlubId || x.GostId == klub.KlubId).OrderByDescending(x => x.RedniBrojKola)
                    .Select(x => x.Pobjednik == klub.KlubId ? "P" : x.Pobjednik == null ? "N" : "I").Take(4).ToList();
                formaView.Add(new FormaView() { Klub = klub.Naziv, Forma = forma });
            }

            return formaView;
        }

        public int GetMaxBrojKola(int ligaId)
        {
            var matchEntity = Context.Set<Match>();
            var maxBrojKola = matchEntity.Where(x => x.LigaId == ligaId).Max(x => x.RedniBrojKola);
            return maxBrojKola;
        }
    }
}
