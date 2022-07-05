using System;
using System.Collections.Generic;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class Klub
    {
        public Klub()
        {
            Fudbalers = new HashSet<Fudbaler>();
            LigaKlubs = new HashSet<LigaKlub>();
            MatchDomacins = new HashSet<Match>();
            MatchGosts = new HashSet<Match>();
            Transfers = new HashSet<Transfer>();
        }

        public int KlubId { get; set; }
        public string Naziv { get; set; }
        public DateTime? DatumOsnivanja { get; set; }
        public string Nadimak { get; set; }
        public int GradId { get; set; }
        public int GodinaOsnivanja { get; set; }

        public virtual Grad Grad { get; set; }
        public virtual ICollection<Fudbaler> Fudbalers { get; set; }
        public virtual ICollection<LigaKlub> LigaKlubs { get; set; }
        public virtual ICollection<Match> MatchDomacins { get; set; }
        public virtual ICollection<Match> MatchGosts { get; set; }
        public virtual ICollection<Transfer> Transfers { get; set; }
    }
}
