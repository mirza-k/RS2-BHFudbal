using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.Database
{
    public partial class KorisničkiRačun
    {
        public KorisničkiRačun()
        {
            Korisniks = new HashSet<Korisnik>();
        }

        public int KorisničkiRačunId { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }

        public virtual ICollection<Korisnik> Korisniks { get; set; }
    }
}
