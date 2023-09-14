using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;

namespace BHFudbal.Services.Interfaces
{
    public interface IFudbalerService : ICRUDService<Model.Fudbaler, FudbalerSearchObject, FudbalerInsertRequest, FudbalerUpdateRequest>
    {
        public FudbalerDetails GetFudbaler(int fudbalerId);
    }
}
