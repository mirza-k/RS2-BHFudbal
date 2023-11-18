using System;
using System.Collections.Generic;
using System.Text;

namespace BHFudbal.Model
{
    public class MatchesByKlubId
    {
        public int BrojDatihGolova { get; set; }
        public int BrojPrimljenihGolova { get; set; }
        public List<string> Rezultati { get; set; }
    }
}
