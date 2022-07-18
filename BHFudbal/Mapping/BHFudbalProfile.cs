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
            CreateMap<Fudbaler, Model.Fudbaler>().ForMember(m => m.Klub, db => db.MapFrom(x => x.Klub.Naziv));

            //Liga
            CreateMap<LigaId, Model.Liga>();
        }
    }
}
