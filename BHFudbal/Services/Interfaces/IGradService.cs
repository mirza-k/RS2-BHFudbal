using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;

namespace BHFudbal.Services.Interfaces
{
    public interface IGradService : ICRUDService<Model.Grad, GradSearchObject, GradInsertRequest, GradUpdateRequest>
    {
    }
}
