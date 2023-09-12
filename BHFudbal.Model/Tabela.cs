namespace BHFudbal.Model
{
    public class Tabela
    {
        public string NazivKluba { get; set; }
        public int BrojBodova { get; set; }
        public Tabela(string nazivKluba, int brojBodova)
        {
            this.NazivKluba = nazivKluba;
            this.BrojBodova = brojBodova;
        }
    }
}
