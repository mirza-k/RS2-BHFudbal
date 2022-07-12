using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;

namespace BHFudbal.Controllers
{
    public class FudbalerController: BaseCRUDController<Model.Fudbaler, FudbalerSearchObject, FudbalerInsertRequest, FudbalerUpdateRequest>
    {
        public FudbalerController(IFudbalerService service): base(service)
        {
        }
    }
}
