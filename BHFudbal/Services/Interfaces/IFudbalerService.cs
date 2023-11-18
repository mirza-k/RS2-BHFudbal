using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using System.Collections.Generic;

namespace BHFudbal.Services.Interfaces
{
    public interface IFudbalerService : ICRUDService<Model.Fudbaler, FudbalerSearchObject, FudbalerInsertRequest, FudbalerUpdateRequest>
    {
        public FudbalerDetails GetFudbaler(int fudbalerId);
        public List<FudbalerHistorijaTransfera> GetFudbalerHistorijaTransfera(int fudbalerId);
        public void DodajOmiljeniFudbaler(OmiljeniFudbalerInsertRequest request);
        public void UkloniOmiljeniFudbaler(OmiljeniFudbalerInsertRequest request);
        public int GetRating(int korisnikId, int fudbalerId);

    }
}
