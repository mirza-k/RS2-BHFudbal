using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Services;
using BHFudbal.Services.Implementations;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace BHFudbal
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddAutoMapper(typeof(Startup));
            services.AddControllers();

            // Register the Swagger generator, defining 1 or more Swagger documents
            services.AddSwaggerGen();

            services.AddDbContext<BHFudbalDBContext>(options => options.UseSqlServer(Configuration.GetConnectionString("BHFudbalDB")));

            services.AddScoped<IDrzavaService, DrzavaService>();
            services.AddScoped<IGradService, GradService>();
            services.AddScoped<IKlubService, KlubService>();
            services.AddScoped<IFudbalerService, FudbalerService>();
            services.AddScoped<IKorisnikService, KorisnikService>();
            services.AddScoped<ILigaService, LigaService>();
            services.AddScoped<ITransferService, TransferService>();
            services.AddScoped<ISezonaService, SezonaService>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            // Enable middleware to serve generated Swagger as a JSON endpoint.
            app.UseSwagger();

            // Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.)
            app.UseSwaggerUI();
             
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
