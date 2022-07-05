using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using System.Collections.Generic;
using System.Linq;

namespace BHFudbal.Services
{
    public class BaseReadService<T, TDb, TSearch> : IReadService<T, TSearch> where T : class where TDb : class where TSearch : class
    {
        public BHFudbalDBContext Context { get; set; }
        protected readonly IMapper _mapper;
        public BaseReadService(BHFudbalDBContext context, IMapper mapper)
        {
            Context = context;
            _mapper = mapper;
        }
        public virtual IEnumerable<T> Get(TSearch search = null)
        {
            var entity = Context.Set<TDb>();
            var listOfEntities = entity.ToList();
            return _mapper.Map<List<T>>(listOfEntities).ToList();
        }

        public virtual T GetById(int id)
        {
            var set = Context.Set<TDb>();
            var entity = set.Find(id);
            return _mapper.Map<T>(entity);
        }
    }
}
