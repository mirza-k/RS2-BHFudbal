using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class Fudbaler
    {
        public Fudbaler()
        {
            FudbalerMatches = new HashSet<FudbalerMatch>();
            FudbalerStatistikas = new HashSet<FudbalerStatistika>();
            Transfers = new HashSet<Transfer>();
        }

        public int FudbalerId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Visina { get; set; }
        public string Težina { get; set; }
        public DateTime DatumRodjenja { get; set; }
        public int KlubId { get; set; }
        public int DrzavaId { get; set; }
        public string JačaNoga { get; set; }
        public byte[] Slika { get; set; }

        public virtual Klub Klub { get; set; }
        public virtual Država Drzava { get; set; }
        public virtual ICollection<FudbalerMatch> FudbalerMatches { get; set; }
        public virtual ICollection<FudbalerStatistika> FudbalerStatistikas { get; set; }
        public virtual ICollection<Transfer> Transfers { get; set; }
    }
}
