using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace BHFudbal.Controllers
{
    public class FudbalerController: BaseCRUDController<Model.Fudbaler, FudbalerSearchObject, FudbalerInsertRequest, FudbalerUpdateRequest>
    {
        IFudbalerService _fudbalerService;
        public FudbalerController(IFudbalerService service): base(service)
        {
            _fudbalerService = service;
        }
        [HttpGet("/details/{fudbalerId}")]
        public FudbalerDetails GetFudbalerDetails(int fudbalerId)
        {
            return _fudbalerService.GetFudbaler(fudbalerId);
        }
    }
}
