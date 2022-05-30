using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.Database
{
    public partial class LigaId
    {
        public LigaId()
        {
            LigaKlubs = new HashSet<LigaKlub>();
            Matches = new HashSet<Match>();
        }

        public int LigaId1 { get; set; }
        public string Naziv { get; set; }

        public virtual ICollection<LigaKlub> LigaKlubs { get; set; }
        public virtual ICollection<Match> Matches { get; set; }
    }
}
