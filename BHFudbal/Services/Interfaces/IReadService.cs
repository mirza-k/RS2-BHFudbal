using System.Collections.Generic;

namespace BHFudbal.Services
{
    public interface IReadService<T, TSearch> where T : class where TSearch : class
    {
        public IEnumerable<T> Get(TSearch search = null);
        public T GetById(int id);
    }
}
