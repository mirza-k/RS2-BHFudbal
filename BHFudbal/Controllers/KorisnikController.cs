using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace BHFudbal.Controllers
{
    public class KorisnikController : BaseCRUDController<Model.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        private readonly IKorisnikService _korisnikService;
        public KorisnikController(IKorisnikService service) : base(service)
        {
            _korisnikService = service;
        }

        [HttpPost("login")]
        public bool Login([FromBody] KorisnikInsertRequest login)
        {
            return _korisnikService.Login(login);
        }
    }
}
