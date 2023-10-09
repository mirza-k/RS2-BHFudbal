namespace BHFudbal.Model
{
    public class Tabela
    {
        public string NazivKluba { get; set; }
        public int BrojBodova { get; set; }
        public int BrojOdigranihUtakmica { get; set; }
        public Tabela(string nazivKluba, int brojBodova, int brojKola)
        {
            this.NazivKluba = nazivKluba;
            this.BrojBodova = brojBodova;
            this.BrojOdigranihUtakmica = brojKola;
        }
    }
}
