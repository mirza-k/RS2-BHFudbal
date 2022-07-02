using AutoMapper;

namespace BHFudbal.Mapping
{
    public class BHFudbalProfile : Profile
    {
        public BHFudbalProfile()
        {
            CreateMap<Database.Država, Model.Drzava>();
            CreateMap<Database.Grad, Model.Grad>();
        }
    }
}
