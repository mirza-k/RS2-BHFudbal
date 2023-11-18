namespace BHFudbal.BHFudbalDatabase
{
    public class Gol
    {
        public int GolId { get; set; }
        public int MatchId { get; set; }
        public Match Match { get; set; }
        public int FudbalerId { get; set; }
        public Fudbaler Fudbaler { get; set; }
        public int MinutaGola { get; set; }
    }
}
