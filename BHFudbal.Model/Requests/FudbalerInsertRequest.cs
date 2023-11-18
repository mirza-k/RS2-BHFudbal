using System;

namespace BHFudbal.Model.Requests
{
    public class FudbalerInsertRequest
    {
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Visina { get; set; }
        public string Težina { get; set; }
        public DateTime DatumRodjenja { get; set; }
        public int GradId { get; set; } = 1;
        public int DrzavaId { get; set; } = 1;
        public int KlubId { get; set; }
        public string JačaNoga { get; set; }
        public byte[] Slika { get; set; }
    }
}
