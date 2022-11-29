using System;

namespace BHFudbal.Model.Requests
{
    public class KlubUpdateRequest
    {
        public string Naziv { get; set; }
        public int GodinaOsnivanja { get; set; }
        public string Nadimak { get; set; }
        public string Grad { get; set; }
        public int GradId { get; set; }
        public int KlubId { get; set; }
        public string Liga { get; set; }
        public int LigaId { get; set; }
        public byte[] Grb { get; set; }
    }
}
