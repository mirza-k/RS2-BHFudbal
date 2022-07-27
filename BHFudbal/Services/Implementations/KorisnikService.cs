using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace BHFudbal.Services.Implementations
{
    public class KorisnikService : BaseCRUDService<Model.Korisnik, KorisnikSearchObject, Korisnik, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService
    {
        public KorisnikService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public bool Login(KorisnikInsertRequest login)
        {
            var query = Context.Set<Korisnik>().Include(x => x.KorisničkiRačun).AsQueryable();

            if (!string.IsNullOrEmpty(login?.Username) && !string.IsNullOrEmpty(login?.Password))
            {
                return query.Any(x => login.Username == x.KorisničkiRačun.Username && login.Password == x.KorisničkiRačun.Password);
            }

            return false;
        }

        public override IEnumerable<Model.Korisnik> Get(KorisnikSearchObject search = null)
        {
            var entity = Context.Set<Korisnik>().AsQueryable();

            if(search?.Ime != null)
            {
                entity = entity.Where(x => x.Ime.Contains(search.Ime));
            }

            entity = entity.Include(x => x.Grad).Include(x => x.KorisničkiRačun).Include(x => x.Uloga);

            return _mapper.Map<List<Model.Korisnik>>(entity);
        }
    }
}
