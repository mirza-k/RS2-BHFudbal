using System;

namespace BHFudbal.Model
{
    public class Fudbaler
    {
        public int FudbalerId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Visina { get; set; }
        public string Težina { get; set; }
        public DateTime DatumRodjenja { get; set; }
        public int Grad { get; set; }
        public int KlubId { get; set; }
        public string Klub { get; set; }
        public string JačaNoga { get; set; }
        public int DrzavaId { get; set; }
        public byte[] Slika { get; set; }
    }
}
