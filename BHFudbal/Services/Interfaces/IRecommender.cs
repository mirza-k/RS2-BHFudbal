using System.Collections.Generic;

namespace BHFudbal.Services.Interfaces
{
    public interface IRecommender
    {
        public List<Model.Fudbaler> GetSlicneFudbalere(int fudbalerId);
    }
}
