using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;

namespace BHFudbal.Controllers
{
    public class TransferController : BaseCRUDController<Model.Transfer, TransferSearchObject, TransferInsertRequest, TransferUpdateRequest>
    {
        public TransferController(ITransferService service) : base(service)
        {
        }
    }
}
