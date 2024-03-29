﻿using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using System.Collections.Generic;

namespace BHFudbal.Services.Interfaces
{
    public interface IKorisnikService : ICRUDService<Model.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        public int Login(KorisnikInsertRequest login);
        public bool Registracija(RegistracijaRequest registracijaRequest);
        public int Uredi(UrediKorisnika request);
        public int UpdateToPremium(UpdateToPremiumRequest request);
        public int IsKorisnikPremium(UpdateToPremiumRequest request);
        public PremiumReport PremiumReport(int sezonaId);
    }
}
