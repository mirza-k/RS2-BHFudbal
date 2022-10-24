using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;

namespace BHFudbal.Services.Interfaces
{
    public interface IMatchService : ICRUDService<Model.Match, MatchSearchObject, MatchInsertRequest, MatchUpdateRequest>
    {
    }
}
