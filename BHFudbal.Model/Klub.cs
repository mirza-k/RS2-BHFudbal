using System;

namespace BHFudbal.Model
{
    public class Klub
    {
        public int KlubId { get; set; }
        public string Naziv { get; set; }
        public int GodinaOsnivanja { get; set; }
        public string Nadimak { get; set; }
        public string Grad { get; set; }
    }
}
