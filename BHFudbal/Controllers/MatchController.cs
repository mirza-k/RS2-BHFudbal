using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BHFudbal.Controllers
{
    public class MatchController : BaseCRUDController<Model.Match,MatchSearchObject,MatchInsertRequest,MatchUpdateRequest>
    {
        public MatchController(IMatchService service): base(service)
        {
        }
    }
}
