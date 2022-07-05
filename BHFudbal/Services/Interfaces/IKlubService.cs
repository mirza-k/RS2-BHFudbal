using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;

namespace BHFudbal.Services.Interfaces
{
    public interface IKlubService : ICRUDService<Model.Klub, KlubSearchObject, KlubInsertRequest, KlubUpdateRequest>
    {
    }
}
