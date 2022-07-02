using BHFudbal.Services;

namespace BHFudbal.Controllers
{
    public class DrzavaController : BaseReadController<Model.Drzava, object> 
    {
        public DrzavaController(IDrzavaService service) : base(service) { }
    }
}
