using System;

namespace BHFudbal.Model
{
    public class Korisnik
    {
        public int KorisnikId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public DateTime DatumRodjenja { get; set; }
        public int GradId { get; set; }
        public string Grad { get; set; }
        public int UlogaId { get; set; }
        public string Uloga { get; set; }
        public int DržavaId { get; set; }
        public int KorisničkiRačunId { get; set; }
        public bool IsPremium { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
    }
}
