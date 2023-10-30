using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

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
        [AllowAnonymous]
        public int Login([FromBody] KorisnikInsertRequest login)
        {
            return _korisnikService.Login(login);
        }

        [HttpPost("Registracija")]
        [AllowAnonymous]
        public bool Registracija([FromBody] RegistracijaRequest registracijaRequest)
        {
            return _korisnikService.Registracija(registracijaRequest);
        }

        [HttpPost("Uredi")]
        public int Uredi([FromBody] UrediKorisnika request)
        {
            return _korisnikService.Uredi(request);
        }

        [HttpPost("UpdateToPremium")]
        public int UpdateToPremium([FromBody] UpdateToPremiumRequest request)
        {
            return _korisnikService.UpdateToPremium(request);
        }

        [HttpPost("IsKorisnikPremium")]
        public int IsKorisnikPremium([FromBody] UpdateToPremiumRequest request)
        {
            return _korisnikService.IsKorisnikPremium(request);
        }
        [HttpGet("Report/{sezonaId}")]
        public PremiumReport PremiumReport(int sezonaId)
        {
           return _korisnikService.PremiumReport(sezonaId);
        }
    }
}
