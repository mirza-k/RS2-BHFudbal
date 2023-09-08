using System;
using System.Collections.Generic;
using System.Text;

namespace BHFudbal.Model.Requests
{
    public class RegistracijaRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Ime { get; set; }
        public string Prezime{ get; set; }
        public int DržavaId { get; set; }
        public DateTime DatumRodjenja { get; set; }
        public int GradId { get; set; } = 1;
        public int UlogaId { get; set; } = 2;
        public bool IsPremium { get; set; } = false;
        public int KorisničkiRačunId { get; set; }

    }
}
