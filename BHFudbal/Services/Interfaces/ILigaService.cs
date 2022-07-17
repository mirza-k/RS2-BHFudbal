using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BHFudbal.Services.Interfaces
{
    public interface ILigaService: ICRUDService<Model.Liga, LigaSearchObject, LigaInsertRequest, LigaUpdateRequest>
    {
    }
}
