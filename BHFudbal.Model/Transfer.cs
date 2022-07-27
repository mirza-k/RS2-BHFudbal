using System;
using System.Collections.Generic;
using System.Text;

namespace BHFudbal.Model
{
    public class Transfer
    {
        public int TransferId { get; set; }
        public int Cijena { get; set; }
        public int KlubId { get; set; }
        public string NazivKluba { get; set; }
        public int FudbalerId { get; set; }
        public string ImeFudbalera { get; set; }
        public int SezonaId { get; set; }
        public string NazivSezone { get; set; }
        public int BrojGodinaUgovora { get; set; }
        public string StariKlub { get; set; }
    }
}
