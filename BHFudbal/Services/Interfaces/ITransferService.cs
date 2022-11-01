using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using System.Collections.Generic;

namespace BHFudbal.Services.Interfaces
{
    public interface ITransferService:ICRUDService<Model.Transfer,TransferSearchObject, TransferInsertRequest, TransferUpdateRequest>
    {
        public IEnumerable<Model.Report> Report(int sezonaId);
    }
}
