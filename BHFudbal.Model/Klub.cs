﻿using System;

namespace BHFudbal.Model
{
    public class Klub
    {
        public int KlubId { get; set; }
        public string Naziv { get; set; }
        public int GodinaOsnivanja { get; set; }
        public string Nadimak { get; set; }
        public string Grad { get; set; }
        public int GradId { get; set; }
        public string Liga { get; set; }
        public int LigaId { get; set; }
        public byte[] Grb { get; set; }
        public string Stadion { get; set; }
    }
}
