using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class Match
    {
        public Match()
        {
            FudbalerMatches = new HashSet<FudbalerMatch>();
        }

        public int MatchId { get; set; }
        public string Stadion { get; set; }
        public DateTime Datum { get; set; }
        public int DomacinId { get; set; }
        public int GostId { get; set; }
        public int LigaId { get; set; }
        public string Rezultat { get; set; }
        public int RedniBrojKola { get; set; }
        public int? Pobjednik{ get; set; }

        public virtual Klub Domacin { get; set; }
        public virtual Klub Gost { get; set; }
        public virtual LigaId Liga { get; set; }
        public virtual ICollection<FudbalerMatch> FudbalerMatches { get; set; }
    }
}
