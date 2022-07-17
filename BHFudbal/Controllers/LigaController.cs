using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;

namespace BHFudbal.Controllers
{
    public class LigaController : BaseCRUDController<Model.Liga, LigaSearchObject, LigaInsertRequest, LigaUpdateRequest>
    {
        public LigaController(ILigaService service) : base(service)
        {
        }
    }
}
