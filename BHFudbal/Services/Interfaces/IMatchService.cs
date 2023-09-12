using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using System.Collections.Generic;

namespace BHFudbal.Services.Interfaces
{
    public interface IMatchService : ICRUDService<Model.Match, MatchSearchObject, MatchInsertRequest, MatchUpdateRequest>
    {
        public MatchDetails GetDetails(int matchId);
        public List<Tabela> GetTabelaByLigaId(int ligaId);
        public MatchesByKlubId GetMatchesByKlubIds(int klubId, int? sezona);
    }
}
