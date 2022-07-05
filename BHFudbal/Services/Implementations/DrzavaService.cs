using AutoMapper;
using BHFudbal.BHFudbalDatabase;

namespace BHFudbal.Services
{
    public class DrzavaService : BaseReadService<Model.Drzava, Država, object>, IDrzavaService
    {
        public DrzavaService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper) { }
    }
}
