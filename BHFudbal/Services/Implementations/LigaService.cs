using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;

namespace BHFudbal.Services.Implementations
{
    public class LigaService : BaseCRUDService<Model.Liga, LigaSearchObject, LigaId, LigaInsertRequest, LigaUpdateRequest>, ILigaService
    {
        public LigaService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
