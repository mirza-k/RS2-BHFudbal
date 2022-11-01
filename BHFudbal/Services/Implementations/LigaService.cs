using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using System.Collections.Generic;
using System.Linq;

namespace BHFudbal.Services.Implementations
{
    public class LigaService : BaseCRUDService<Model.Liga, LigaSearchObject, LigaId, LigaInsertRequest, LigaUpdateRequest>, ILigaService
    {
        public LigaService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IEnumerable<Liga> Get(LigaSearchObject search = null)
        {
            var entity = Context.Set<BHFudbal.BHFudbalDatabase.LigaId>().AsQueryable();
            if (search?.SezonaId != 0)
            {
                entity = entity.Where(x => x.SezonaId == search.SezonaId);
            }

            return _mapper.Map<List<Model.Liga>>(entity);
        }
    }
}
