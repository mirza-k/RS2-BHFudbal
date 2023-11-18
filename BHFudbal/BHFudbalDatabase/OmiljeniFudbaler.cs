namespace BHFudbal.BHFudbalDatabase
{
    public class OmiljeniFudbaler
    {
        public int OmiljeniFudbalerId { get; set; }
        public int FudbalerId { get; set; }
        public Fudbaler Fudbaler { get; set; }
        public int KorisnikId { get; set; }
        public Korisnik Korisnik { get; set; }
        public int Rating { get; set; }
    }
}
