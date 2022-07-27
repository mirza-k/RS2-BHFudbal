using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using System.Collections.Generic;
using System.Linq;

namespace BHFudbal.Services.Implementations
{
    public class SezonaService : BaseCRUDService<Model.Sezona, SezonaSearchObject, Sezona, SezonaInsertRequest, SezonaUpdateRequest>, ISezonaService
    {
        public SezonaService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IEnumerable<Model.Sezona> Get(SezonaSearchObject search = null)
        {
            var entity = Context.Set<Sezona>().AsQueryable();

            return _mapper.Map<List<Model.Sezona>>(entity);
        }
    }
}
