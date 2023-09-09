namespace BHFudbal.BHFudbalDatabase
{
    public class CrveniKarton
    {
        public int CrveniKartonId { get; set; }
        public int MatchId { get; set; }
        public Match Match { get; set; }
        public int FudbalerId { get; set; }
        public Fudbaler Fudbaler { get; set; }
        public int MinutaKartona { get; set; }
    }
}
