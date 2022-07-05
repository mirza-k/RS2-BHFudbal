using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class Korisnik
    {
        public int KorisnikId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public DateTime DatumRodjenja { get; set; }
        public int GradId { get; set; }
        public int UlogaId { get; set; }
        public int DržavaId { get; set; }
        public int KorisničkiRačunId { get; set; }
        public bool IsPremium { get; set; }

        public virtual Država Država { get; set; }
        public virtual Grad Grad { get; set; }
        public virtual KorisničkiRačun KorisničkiRačun { get; set; }
        public virtual Uloga Uloga { get; set; }
    }
}
