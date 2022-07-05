using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class Sezona
    {
        public Sezona()
        {
            FudbalerStatistikas = new HashSet<FudbalerStatistika>();
            LigaKlubs = new HashSet<LigaKlub>();
            Transfers = new HashSet<Transfer>();
        }

        public int SezonaId { get; set; }
        public string Naziv { get; set; }
        public bool Aktivna { get; set; }

        public virtual ICollection<FudbalerStatistika> FudbalerStatistikas { get; set; }
        public virtual ICollection<LigaKlub> LigaKlubs { get; set; }
        public virtual ICollection<Transfer> Transfers { get; set; }
    }
}
