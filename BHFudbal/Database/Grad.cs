using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.Database
{
    public partial class Grad
    {
        public Grad()
        {
            Fudbalers = new HashSet<Fudbaler>();
            Klubs = new HashSet<Klub>();
            Korisniks = new HashSet<Korisnik>();
        }

        public int GradId { get; set; }
        public string Naziv { get; set; }

        public virtual ICollection<Fudbaler> Fudbalers { get; set; }
        public virtual ICollection<Klub> Klubs { get; set; }
        public virtual ICollection<Korisnik> Korisniks { get; set; }
    }
}
