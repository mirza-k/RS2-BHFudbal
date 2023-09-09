using System;
using System.Collections.Generic;
using System.Text;

namespace BHFudbal.Model
{
    public class MatchDetails
    {
        public int MatchId { get; set; }
        public string Rezultat { get; set; }
        public List<GolDetails> GolDetails { get; set; }
    }
}
