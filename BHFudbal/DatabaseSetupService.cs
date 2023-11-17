using BHFudbal.BHFudbalDatabase;
using Microsoft.EntityFrameworkCore;
using System.IO;

namespace BHFudbal
{
    public class DatabaseSetupService
    {
        public void Init(BHFudbalDBContext context)
        {
            context.Database.Migrate();
        }

        public void InsertData(BHFudbalDBContext context)
        {
            var path = Path.Combine(Directory.GetCurrentDirectory(), "Script", "seed_script.sql");
            var query = File.ReadAllText(path);
            context.Database.ExecuteSqlRaw(query);
        }
    }
}
