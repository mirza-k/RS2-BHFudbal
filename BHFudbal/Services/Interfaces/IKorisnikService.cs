using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;

namespace BHFudbal.Services.Interfaces
{
    public interface IKorisnikService : ICRUDService<Model.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        public bool Login(KorisnikInsertRequest login);
    }
}
