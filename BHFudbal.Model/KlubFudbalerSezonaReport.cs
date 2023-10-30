using System.Collections.Generic;

namespace BHFudbal.Model
{
    public class KlubFudbalerSezonaReport
    {
        public string NazivKluba { get; set; }
        public List<FudbalerReport> FudbalerReport { get; set; }
    }

    public class FudbalerReport
    {
        public string ImeFudbalera { get; set; }
        public string BrojGolova { get; set; }
        public string BrojZutih { get; set; }
        public string BrojCrvenih { get; set; }
    }
}
