using System.Collections.Generic;

namespace BHFudbal.Model
{
    public class PremiumReport
    {
        public List<FinancijskiRezultati> FinancijskiRezultati { get; set; }
        public List<KlubGoloviReport> KlubGoloviReport { get; set; }
        public List<KlubFudbalerSezonaReport> KlubFudbalerSezonaReport { get; set; }
    }
}
