using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class FudbalerMatch
    {
        public int FudbalerMatchId { get; set; }
        public int Golovi { get; set; }
        public int Asistencije { get; set; }
        public int ŽutiKarton { get; set; }
        public int CrveniKarton { get; set; }
        public int MatchId { get; set; }
        public int FudbalerId { get; set; }

        public virtual Fudbaler Fudbaler { get; set; }
        public virtual Match Match { get; set; }
    }
}
