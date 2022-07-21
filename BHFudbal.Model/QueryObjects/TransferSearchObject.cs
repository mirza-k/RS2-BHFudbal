using System;
using System.Collections.Generic;
using System.Text;

namespace BHFudbal.Model.QueryObjects
{
    public class TransferSearchObject
    {
        public int TransferId { get; set; }
        public int KlubId { get; set; }
        public int FudbalerId { get; set; }
        public int SezonaId { get; set; }
    }
}
