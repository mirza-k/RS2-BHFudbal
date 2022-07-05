using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class Statistika
    {
        public Statistika()
        {
            FudbalerStatistikas = new HashSet<FudbalerStatistika>();
        }

        public int StatistikaId { get; set; }
        public int Golovi { get; set; }
        public int Asistencije { get; set; }
        public int ŽutiKartoni { get; set; }
        public int CrveniKartoni { get; set; }

        public virtual ICollection<FudbalerStatistika> FudbalerStatistikas { get; set; }
    }
}
