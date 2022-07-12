using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;

namespace BHFudbal.Services.Implementations
{
    public class FudbalerService : BaseCRUDService<Model.Fudbaler, FudbalerSearchObject, Fudbaler, FudbalerInsertRequest, FudbalerUpdateRequest>, IFudbalerService
    {
        public FudbalerService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        { }
    }
}
