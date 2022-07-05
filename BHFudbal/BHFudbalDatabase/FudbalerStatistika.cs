using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class FudbalerStatistika
    {
        public int FudbalerStatistikaId { get; set; }
        public int FudbalerId { get; set; }
        public int StatistikaId { get; set; }
        public int SezonaId { get; set; }

        public virtual Fudbaler Fudbaler { get; set; }
        public virtual Sezona Sezona { get; set; }
        public virtual Statistika Statistika { get; set; }
    }
}
