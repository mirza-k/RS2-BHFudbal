using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;

namespace BHFudbal.Controllers
{
    //[Authorize(Roles = "Admin")]
    public class KlubController : BaseCRUDController<Model.Klub, KlubSearchObject, KlubInsertRequest, KlubUpdateRequest>
    {
        public KlubController(IKlubService service) : base(service)
        {
        }
    }
}
