using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace BHFudbal.Controllers
{
    public class TransferController : BaseCRUDController<Model.Transfer, TransferSearchObject, TransferInsertRequest, TransferUpdateRequest>
    {
        ITransferService service;
        public TransferController(ITransferService service) : base(service)
        {
            this.service = service;
        }

        [HttpGet("Report")]
        public IEnumerable<Model.Report> Report(int sezonaId)
        {
            return this.service.Report(sezonaId);
        }
    }
}
