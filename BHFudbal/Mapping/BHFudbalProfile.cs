using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model.Requests;

namespace BHFudbal.Mapping
{
    public class BHFudbalProfile : Profile
    {
        public BHFudbalProfile()
        {
            //Drzava
            CreateMap<Država, Model.Drzava>();

            //Grad
            CreateMap<GradInsertRequest, Grad>().ReverseMap();
            CreateMap<Grad, Model.Grad>().ReverseMap();

            //Klub
            CreateMap<KlubInsertRequest, Klub>().ReverseMap();
            CreateMap<KlubUpdateRequest, Klub>().ReverseMap();
            CreateMap<Klub, Model.Klub>()
                .ForMember(m => m.Liga, db => db.MapFrom(x => x.Liga.Naziv))
                .ForMember(m => m.Grad, db => db.MapFrom(x => x.Grad.Naziv));

            //Fudbaler
            CreateMap<FudbalerInsertRequest, Fudbaler>();
            CreateMap<FudbalerUpdateRequest, Fudbaler>();
            CreateMap<Fudbaler, Model.Fudbaler>()
                .ForMember(m => m.Klub, db => db.MapFrom(x => x.Klub.Naziv))
                .ForMember(m => m.Drzava, db => db.MapFrom(x => x.Drzava.Naziv));

            //Liga
            CreateMap<LigaId, Model.Liga>();

            //Transfer
            CreateMap<TransferInsertRequest, Transfer>();
            CreateMap<Transfer, Model.Transfer>()
                .ForMember(m => m.ImeFudbalera, db => db.MapFrom(x => x.Fudbaler.Ime + " " + x.Fudbaler.Prezime))
                .ForMember(m => m.NazivSezone, db => db.MapFrom(x => x.Sezona.Naziv))
                .ForMember(m => m.NazivKluba, db => db.MapFrom(x => x.Klub.Naziv))
                .ForMember(m => m.StariKlub, db => db.MapFrom(x => x.StariKlub.Naziv));

            //Korisnik
            CreateMap<Korisnik, Model.Korisnik>()
                .ForMember(m => m.Grad, db => db.MapFrom(x => x.Grad.Naziv))
                .ForMember(m => m.Uloga, db => db.MapFrom(x => x.Uloga.Naziv))
                .ForMember(m => m.Username, db => db.MapFrom(x => x.KorisničkiRačun.Username));

            //Sezona
            CreateMap<Sezona, Model.Sezona>();

            //Match
            CreateMap<Match, Model.Match>();
        }
    }
}
