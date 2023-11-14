using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Implementations;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace BHFudbal.Controllers
{
    public class FudbalerController : BaseCRUDController<Model.Fudbaler, FudbalerSearchObject, FudbalerInsertRequest, FudbalerUpdateRequest>
    {
        IFudbalerService _fudbalerService;
        IRecommender _recommender;
        public FudbalerController(IFudbalerService service, IRecommender recommender) : base(service)
        {
            _fudbalerService = service;
            _recommender = recommender;
        }

        [HttpGet("details/{fudbalerId}")]
        public FudbalerDetails GetFudbalerDetails(int fudbalerId)
        {
            return _fudbalerService.GetFudbaler(fudbalerId);
        }

        [HttpGet("transferhistory/{fudbalerId}")]
        public List<FudbalerHistorijaTransfera> GetFudbalerHistorijaTransfera(int fudbalerId)
        {
            return _fudbalerService.GetFudbalerHistorijaTransfera(fudbalerId);
        }

        [HttpPost("OmiljeniFudbaler")]
        public void DodajOmiljeniFudbaler([FromBody] OmiljeniFudbalerInsertRequest request)
        {
            _fudbalerService.DodajOmiljeniFudbaler(request);
        }

        [HttpPost("UkloniOmiljeniFudbaler")]
        public void UkloniOmiljeniFudbaler([FromBody] OmiljeniFudbalerInsertRequest request)
        {
            _fudbalerService.UkloniOmiljeniFudbaler(request);
        }

        [HttpGet("recommended/{fudbalerId}")]
        public List<Model.Fudbaler> GetRecommandedPlayers(int fudbalerId)
        {
            return _recommender.GetSlicneFudbalere(fudbalerId);
        }
    }
}
