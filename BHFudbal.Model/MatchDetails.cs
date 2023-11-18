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
        public List<ZutiKartonDetails> ZutiKartonDetails { get; set; }
        public List<CrveniKartonDetails> CrveniKartonDetails { get; set; }
        public List<string> PostaveDomaci { get; set; }
        public List<string> PostaveGosti { get; set; }
        public string Domaci { get; set; }
        public byte[] DomaciSlika { get; set; }
        public string Gosti { get; set; }
        public byte[] GostiSlika { get; set; }
    }
}
