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
    public class FudbalerService : BaseCRUDService<Model.Fudbaler, FudbalerSearchObject, Fudbaler, FudbalerInsertRequest, FudbalerUpdateRequest>, IFudbalerService
    {
        public FudbalerService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        { }

        public override IEnumerable<Model.Fudbaler> Get(FudbalerSearchObject search = null)
        {
            var entity = Context.Set<Fudbaler>().AsQueryable();
            if(search.KlubId != 0)
            {
                entity = entity.Where(x => x.KlubId == search.KlubId);
            }

            entity = entity.Include(x => x.Klub);

            return _mapper.Map<List<Model.Fudbaler>>(entity);
        }
    }
}
