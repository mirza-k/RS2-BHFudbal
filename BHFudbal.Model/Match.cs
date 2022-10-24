using System;
using System.Collections.Generic;
using System.Text;

namespace BHFudbal.Model
{
    public class Match
    {
        public int MatchId { get; set; }
        public int LigaId { get; set; }
        public int DomacinId { get; set; }
        public int GostId { get; set; }
        public string Rezultat { get; set; }
        public int RedniBrojKola { get; set; }
        public string Prikaz{ get; set; }
    }
}
