using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;

namespace BHFudbal.Controllers
{
    public class SezonaController : BaseCRUDController<Model.Sezona, SezonaSearchObject, SezonaInsertRequest, SezonaUpdateRequest>
    {
        public SezonaController(ISezonaService service) : base(service)
        {
        }
    }
}
