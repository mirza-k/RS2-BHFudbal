using System;

namespace BHFudbal.Model.Requests
{
    public class KlubInsertRequest
    {
        public string Naziv { get; set; }
        public int GodinaOsnivanja { get; set; }
        public string Nadimak { get; set; }
        public int GradId { get; set; }
        public int LigaId { get; set; }
        public byte[] Grb { get; set; }
    }
}
