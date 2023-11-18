namespace BHFudbal.BHFudbalDatabase
{
    public class ZutiKarton
    {
        public int ZutiKartonId { get; set; }
        public int MatchId { get; set; }
        public Match Match { get; set; }
        public int FudbalerId { get; set; }
        public Fudbaler Fudbaler { get; set; }
        public int MinutaKartona { get; set; }
    }
}
