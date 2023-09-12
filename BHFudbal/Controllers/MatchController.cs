using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;

namespace BHFudbal.Controllers
{
    public class MatchController : BaseCRUDController<Model.Match,MatchSearchObject,MatchInsertRequest,MatchUpdateRequest>
    {
        IMatchService _matchService;
        public MatchController(IMatchService service): base(service)
        {
            _matchService = service;
        }

        [HttpGet("Details/{matchId}")]
        public MatchDetails GetMatchDetails (int matchId)
        {
            return _matchService.GetDetails(matchId);
        }

        [HttpGet("Tabela/{ligaId}")]
        public List<Tabela> GetTabelaByLigaId(int ligaId)
        {
            return _matchService.GetTabelaByLigaId(ligaId);   
        }
    }
}
