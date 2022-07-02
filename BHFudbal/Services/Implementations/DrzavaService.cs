using AutoMapper;
using BHFudbal.Database;
using System.Collections.Generic;
using System.Linq;

namespace BHFudbal.Services
{
    public class DrzavaService : BaseReadService<Model.Drzava, Država, object>, IDrzavaService
    {
        public DrzavaService(BHFudbalContext context, IMapper mapper) : base(context, mapper) { }
    }
}
