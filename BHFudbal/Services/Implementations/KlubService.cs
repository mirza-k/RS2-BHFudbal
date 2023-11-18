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
    public class KlubService : BaseCRUDService<Model.Klub, KlubSearchObject, Klub, KlubInsertRequest, KlubUpdateRequest>, IKlubService
    {
        public KlubService(BHFudbalDBContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IEnumerable<Model.Klub> Get(KlubSearchObject search = null)
        {
            var entity = Context.Set<Klub>().AsQueryable();
            if(search.LigaId != 0)
            {
                entity = entity.Where(x => x.LigaId == search.LigaId);
            }

            if(search.KlubId != 0)
            {
                entity = entity.Where(x => x.KlubId == search.KlubId);
            }

            if(search.Naziv != null && search.Naziv != "")
            {
                entity = entity.Where(x => x.Naziv.Contains(search.Naziv));
            }

            entity = entity.Include(x => x.Liga).Include(x => x.Grad);

            return _mapper.Map<List<Model.Klub>>(entity);
        }

        public override Model.Klub Update(int id, KlubUpdateRequest request)
        {
            var set = Context.Set<Klub>();
            var entity = set.Find(id);
            entity.Naziv = request.Naziv;
            entity.Nadimak = request.Nadimak;
            entity.GodinaOsnivanja = request.GodinaOsnivanja;
            entity.GradId = request.GradId;
            entity.Grb = request.Grb;
            //_mapper.Map(request, entity);
            Context.Entry(entity).State = EntityState.Modified;
            Context.Entry(entity).Collection(x => x.Transfers).IsModified = false;
            Context.Entry(entity).Collection(x => x.Fudbalers).IsModified = false;
            Context.Entry(entity).Collection(x => x.LigaKlubs).IsModified = false;
            Context.Entry(entity).Collection(x => x.MatchDomacins).IsModified = false;
            Context.Entry(entity).Collection(x => x.MatchGosts).IsModified = false;
            Context.SaveChanges();
            return _mapper.Map<Model.Klub>(entity);
        }

    }
}
