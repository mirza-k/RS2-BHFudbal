using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class LigaKlub
    {
        public int LigaKlubId { get; set; }
        public int LigaId { get; set; }
        public int KlubId { get; set; }
        public int SezonaId { get; set; }
        public int BrojBodova { get; set; }
        public int BrojDatihGolova { get; set; }
        public int BrojPrimljenihGolova { get; set; }

        public virtual Klub Klub { get; set; }
        public virtual LigaId Liga { get; set; }
        public virtual Sezona Sezona { get; set; }
    }
}
