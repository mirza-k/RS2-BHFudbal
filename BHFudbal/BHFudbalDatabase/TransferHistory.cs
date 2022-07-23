using System.ComponentModel.DataAnnotations;

namespace BHFudbal.BHFudbalDatabase
{
    public class TransferHistory
    {
        [Key]
        public int TransferHistoryId { get; set; }
        public int StariKlubId{ get; set; }
        public int NoviKlubId{ get; set; }
        public int FudbalerId{ get; set; }
        public int SezonaId{ get; set; }

        public Klub StariKlub { get; set; }
        public Klub NoviKlub { get; set; }
        public Fudbaler Fudbaler { get; set; }
        public Sezona Sezona { get; set; }
    }
}
