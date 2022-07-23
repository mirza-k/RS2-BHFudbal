using System;
using System.Collections.Generic;
using System.Text;

namespace BHFudbal.Model.Requests
{
    public class TransferInsertRequest
    {
        public int Cijena { get; set; }
        public int KlubId { get; set; }
        public int StariKlubId { get; set; }
        public int FudbalerId { get; set; }
        public int SezonaId { get; set; }
        public int BrojGodinaUgovora { get; set; }
    }
}
