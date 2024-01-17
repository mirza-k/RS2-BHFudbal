using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BHFudbal.Services.Implementations
{
    public class Recommender : IRecommender
    {
        private BHFudbalDBContext context { get; set; }
        private Dictionary<int, List<OmiljeniFudbaler>> fudbaleri = new Dictionary<int, List<OmiljeniFudbaler>>();
        private IMapper _mapper;
        public Recommender(BHFudbalDBContext context, IMapper mapper)
        {
            this.context = context;
            _mapper = mapper;
        }

        public List<Model.Fudbaler> GetSlicneFudbalere(int fudbalerId)
        {
            UcitajFudbalere(fudbalerId);
            List<OmiljeniFudbaler> ocjenePosmatranogFudbalera = context.Set<OmiljeniFudbaler>().Where(x => x.FudbalerId == fudbalerId).OrderBy(x => x.KorisnikId).ToList();

            List<OmiljeniFudbaler> zajednickeOcjene1 = new List<OmiljeniFudbaler>();
            List<OmiljeniFudbaler> zajednickeOcjene2 = new List<OmiljeniFudbaler>();
            List<Model.Fudbaler> preporuceniProizvodi = new List<Model.Fudbaler>();

            foreach (var f in fudbaleri)
            {
                foreach (var o in ocjenePosmatranogFudbalera)
                {
                    if (f.Value.Where(x => x.KorisnikId == o.KorisnikId).Count() > 0)
                    {
                        zajednickeOcjene1.Add(o);
                        zajednickeOcjene2.Add(f.Value.Where(x => x.KorisnikId == o.KorisnikId).First());
                    }
                }
                double slicnost = GetSlicnost(zajednickeOcjene1, zajednickeOcjene2);
                if (slicnost >= 0.95)
                {
                    Fudbaler fudbaler = context.Set<Fudbaler>().Include(x => x.Klub).Include(x => x.Drzava).FirstOrDefault(x => x.FudbalerId == f.Key);
                    var model = _mapper.Map<Model.Fudbaler>(fudbaler);
                    preporuceniProizvodi.Add(model);
                }
                zajednickeOcjene1.Clear();
                zajednickeOcjene2.Clear();
            }

            return preporuceniProizvodi;
        }

        private double GetSlicnost(List<OmiljeniFudbaler> zajednickeOcjene1, List<OmiljeniFudbaler> zajednickeOcjene2)
        {
            if (zajednickeOcjene1.Count != zajednickeOcjene2.Count)
                return 0;

            double brojnik = 0, nazivnik1 = 0, nazivnik2 = 0;

            for (int i = 0; i < zajednickeOcjene1.Count; i++)
            {
                brojnik += zajednickeOcjene1[i].Rating * zajednickeOcjene2[i].Rating;
                nazivnik1 += zajednickeOcjene1[i].Rating * zajednickeOcjene1[i].Rating;
                nazivnik2 += zajednickeOcjene2[i].Rating * zajednickeOcjene2[i].Rating;
            }
            nazivnik1 = Math.Sqrt(nazivnik1);
            nazivnik2 = Math.Sqrt(nazivnik2);

            double nazivnik = nazivnik1 * nazivnik2;
            if (nazivnik == 0)
                return 0;

            return brojnik / nazivnik;
        }

        private void UcitajFudbalere(int fudbalerId)
        {
            var entity = context.Set<Fudbaler>();
            List<Fudbaler> aktivniFudbaleri = entity.Where(x => x.FudbalerId != fudbalerId).ToList();
            List<OmiljeniFudbaler> omiljeniFudbalers = new List<OmiljeniFudbaler>();

            foreach (Fudbaler item in aktivniFudbaleri)
            {
                omiljeniFudbalers = context.Set<OmiljeniFudbaler>().Where(x => x.FudbalerId == item.FudbalerId).OrderBy(x => x.KorisnikId).ToList();
                if (omiljeniFudbalers.Count() > 0)
                {
                    fudbaleri.Add(item.FudbalerId, omiljeniFudbalers);
                }
            }
        }
    }
}
