using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.Database
{
    public partial class Država
    {
        public Država()
        {
            Korisniks = new HashSet<Korisnik>();
        }

        public int DržavaId { get; set; }
        public string Naziv { get; set; }

        public virtual ICollection<Korisnik> Korisniks { get; set; }
    }
}
