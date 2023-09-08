using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace BHFudbal.Services.Implementations
{
    public class MatchService : BaseCRUDService<Model.Match, FudbalerSearchObject, Match, MatchInsertRequest, MatchUpdateRequest>, IMatchService
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
            if(search?.RedniBrojKola != null)
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
                Prikaz = x.RedniBrojKola + ".kolo" + "        " + x.Domacin.Naziv + "    " + x.Rezultat + "    " + x.Gost.Naziv
            });

            return _mapper.Map<List<Model.Match>>(models);
        }
    }
}
