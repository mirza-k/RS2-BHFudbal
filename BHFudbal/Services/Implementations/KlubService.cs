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
    public class KlubService : BaseCRUDService<Model.Klub, KlubSearchObject, Klub, KlubInsertRequest, KlubUpdateRequest>, IKlubService
    {
        public KlubService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IEnumerable<Model.Klub> Get(KlubSearchObject search = null)
        {
            var entity = Context.Set<Klub>().AsQueryable();
            if(search.LigaId != 0)
            {
                entity = entity.Where(x => x.LigaId == search.LigaId);
            }

            entity = entity.Include(x => x.Liga).Include(x => x.Grad);

            return _mapper.Map<List<Model.Klub>>(entity);
        }

    }
}
