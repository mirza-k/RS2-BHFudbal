using System;

namespace BHFudbal.Model.Requests
{
    public class KlubUpdateRequest
    {
        public string Naziv { get; set; }
        public int GodinaOsnivanja { get; set; }
        public string Nadimak { get; set; }
        public int GradId { get; set; }
    }
}
