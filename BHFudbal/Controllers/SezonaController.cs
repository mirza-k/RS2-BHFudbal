using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BHFudbal.Controllers
{
    public class SezonaController : BaseCRUDController<Model.Sezona, SezonaSearchObject, SezonaInsertRequest, SezonaUpdateRequest>
    {
        private readonly ISezonaService _sezonaService;
        public SezonaController(ISezonaService service) : base(service)
        {
            _sezonaService = service;
        }

        [AllowAnonymous]
        [HttpGet("GenerisiSezonu")]
        public string GenerisiSezonu()
        {
            var rez = _sezonaService.GenerisiSezonu();
            return rez;
        }
    }
}
