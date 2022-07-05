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
            CreateMap<Klub, Model.Klub>().ReverseMap();
        }
    }
}
