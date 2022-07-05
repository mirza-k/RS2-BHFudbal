using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;

namespace BHFudbal.Services.Implementations
{
    public class KlubService : BaseCRUDService<Model.Klub, KlubSearchObject, Klub, KlubInsertRequest, KlubUpdateRequest>, IKlubService
    {
        public KlubService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
