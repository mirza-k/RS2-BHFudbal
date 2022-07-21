using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace BHFudbal.Services.Implementations
{
    public class TransferService : BaseCRUDService<Model.Transfer, TransferSearchObject, Transfer, TransferInsertRequest, TransferUpdateRequest>, ITransferService
    {
        public TransferService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IEnumerable<Model.Transfer> Get(TransferSearchObject search = null)
        {
            var entity = Context.Set<Transfer>().AsQueryable();

            entity = entity.Include(x => x.Klub).Include(x => x.Sezona).Include(x => x.Fudbaler);

            return _mapper.Map<List<Model.Transfer>>(entity);
        }
    }
}
