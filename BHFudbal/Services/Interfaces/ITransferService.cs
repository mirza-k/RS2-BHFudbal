using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;

namespace BHFudbal.Services.Interfaces
{
    public interface ITransferService:ICRUDService<Model.Transfer,TransferSearchObject, TransferInsertRequest, TransferUpdateRequest>
    {
    }
}
