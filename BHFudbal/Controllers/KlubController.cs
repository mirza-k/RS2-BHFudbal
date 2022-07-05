using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;

namespace BHFudbal.Controllers
{
    public class KlubController : BaseCRUDController<Model.Klub, KlubSearchObject, KlubInsertRequest, KlubUpdateRequest>
    {
        public KlubController(IKlubService service) : base(service)
        {
        }
    }
}
