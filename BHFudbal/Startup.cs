using AutoMapper;
using BHFudbal.BHFudbalDatabase;
using BHFudbal.Security;
using BHFudbal.Services;
using BHFudbal.Services.Implementations;
using BHFudbal.Services.Interfaces;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;
using System;
using System.IO;

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
            services.AddAuthentication("BasicAuthentication")
            .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

            services.AddAutoMapper(typeof(Startup));
            services.AddControllers();

            // Register the Swagger generator, defining 1 or more Swagger documents
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "eProdaja API", Version = "v1" });

                c.AddSecurityDefinition("basicAuth", new OpenApiSecurityScheme
                {
                    Type = SecuritySchemeType.Http,
                    Scheme = "basic"
                });

                c.AddSecurityRequirement(new OpenApiSecurityRequirement
                {
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {Type = ReferenceType.SecurityScheme, Id = "basicAuth"}
                        },
                        new string[]{}
                    }
                });
            });

            services.AddDbContext<BHFudbalDBContext>(options => options.UseSqlServer(Environment.GetEnvironmentVariable("ConnectionStrings_BHFudbalDB")));

            services.AddScoped<IDrzavaService, DrzavaService>();
            services.AddScoped<IGradService, GradService>();
            services.AddScoped<IKlubService, KlubService>();
            services.AddScoped<IFudbalerService, FudbalerService>();
            services.AddScoped<IKorisnikService, KorisnikService>();
            services.AddScoped<ILigaService, LigaService>();
            services.AddScoped<ITransferService, BHFudbal.Services.Implementations.TransferService>();
            services.AddScoped<ISezonaService, SezonaService>();
            services.AddScoped<IMatchService, MatchService>();
            services.AddScoped<IMessageProducer, MessageProducer>();
            services.AddScoped<IRecommender, Recommender>();

            services.AddCors();
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.UseCors(builder =>
            {
                builder.AllowAnyOrigin()
                       .AllowAnyMethod()
                       .AllowAnyHeader();
            });
            app.UseSwagger();

            app.UseSwaggerUI();

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            //app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthentication();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
            //using (var scope = app.ApplicationServices.CreateScope())
            //{
            //    var dataContext = scope.ServiceProvider.GetRequiredService<BHFudbalDBContext>();
            //    //dataContext.Database.Migrate();
            //}
        }
    }
}
