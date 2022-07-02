using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;

namespace BHFudbal.Controllers
{
    public class GradController : BaseCRUDController<Model.Grad, GradSearchObject, GradInsertRequest, GradUpdateRequest>
    {
        public GradController(IGradService service) : base(service) { }
    }
}
