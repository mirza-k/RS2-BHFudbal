using AutoMapper;
using BHFudbal.Database;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using System.Collections.Generic;
using System.Linq;

namespace BHFudbal.Services.Implementations
{
    public class GradService : BaseCRUDService<Model.Grad, GradSearchObject, Grad, GradInsertRequest, GradUpdateRequest>, IGradService
    {
        public GradService(BHFudbalContext context, IMapper mapper) : base(context, mapper) { }

        public override IEnumerable<Model.Grad> Get(GradSearchObject search = null)
        {
            var entity = Context.Set<Grad>().AsQueryable();
            if (!string.IsNullOrEmpty(search?.Naziv))
                entity = entity.Where(x => x.Naziv.Contains(search.Naziv));
            entity.ToList();
            return _mapper.Map<List<Model.Grad>>(entity).ToList();

        }
    }
}
