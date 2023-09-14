using System.Collections.Generic;

namespace BHFudbal.Model
{
    public class FudbalerDetails
    {
        public string ImePrezime { get; set; }
        public string Klub { get; set; }
        public string DatumRodjenja { get; set; }
        public string Visina { get; set; }
        public string Tezina { get; set; }
        public string JacaNoga { get; set; }
        public List<FudbalerMatchDetail> Utakmice { get; set; }
    }

    public class FudbalerMatchDetail
    {
        public int MatchId { get; set; }
        public string Rezultat { get; set; }
        public int Golovi { get; set; }
        public int ZutiKartoni { get; set; }
        public int CrveniKartoni { get; set; }
    }
}
