using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class Transfer
    {
        public int TransferId { get; set; }
        public int Cijena { get; set; }
        public int KlubId { get; set; }
        public int FudbalerId { get; set; }
        public int SezonaId { get; set; }
        public int BrojGodinaUgovora { get; set; }

        public virtual Fudbaler Fudbaler { get; set; }
        public virtual Klub Klub { get; set; }
        public virtual Sezona Sezona { get; set; }
    }
}
