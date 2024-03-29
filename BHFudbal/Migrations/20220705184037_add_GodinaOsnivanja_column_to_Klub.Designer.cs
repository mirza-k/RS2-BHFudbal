﻿// <auto-generated />
using System;
using BHFudbal.BHFudbalDatabase;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace BHFudbal.Migrations
{
    [DbContext(typeof(BHFudbalDBContext))]
    [Migration("20220705184037_add_GodinaOsnivanja_column_to_Klub")]
    partial class add_GodinaOsnivanja_column_to_Klub
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.4")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Država", b =>
                {
                    b.Property<int>("DržavaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("DržavaId");

                    b.ToTable("Država");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Fudbaler", b =>
                {
                    b.Property<int>("FudbalerId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("DatumRodjenja")
                        .HasColumnType("datetime");

                    b.Property<int>("GradId")
                        .HasColumnType("int");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("JačaNoga")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<int>("KlubId")
                        .HasColumnType("int");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Težina")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Visina")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("FudbalerId");

                    b.HasIndex("GradId");

                    b.HasIndex("KlubId");

                    b.ToTable("Fudbaler");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.FudbalerMatch", b =>
                {
                    b.Property<int>("FudbalerMatchId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("Asistencije")
                        .HasColumnType("int");

                    b.Property<int>("CrveniKarton")
                        .HasColumnType("int");

                    b.Property<int>("FudbalerId")
                        .HasColumnType("int");

                    b.Property<int>("Golovi")
                        .HasColumnType("int");

                    b.Property<int>("MatchId")
                        .HasColumnType("int");

                    b.Property<int>("ŽutiKarton")
                        .HasColumnType("int");

                    b.HasKey("FudbalerMatchId");

                    b.HasIndex("FudbalerId");

                    b.HasIndex("MatchId");

                    b.ToTable("FudbalerMatch");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.FudbalerStatistika", b =>
                {
                    b.Property<int>("FudbalerStatistikaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("FudbalerId")
                        .HasColumnType("int");

                    b.Property<int>("SezonaId")
                        .HasColumnType("int");

                    b.Property<int>("StatistikaId")
                        .HasColumnType("int");

                    b.HasKey("FudbalerStatistikaId");

                    b.HasIndex("FudbalerId");

                    b.HasIndex("SezonaId");

                    b.HasIndex("StatistikaId");

                    b.ToTable("FudbalerStatistika");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Grad", b =>
                {
                    b.Property<int>("GradId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("GradId");

                    b.ToTable("Grad");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Klub", b =>
                {
                    b.Property<int>("KlubId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime?>("DatumOsnivanja")
                        .HasColumnType("datetime");

                    b.Property<int>("GodinaOsnivanja")
                        .HasColumnType("int");

                    b.Property<int>("GradId")
                        .HasColumnType("int");

                    b.Property<string>("Nadimak")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("KlubId");

                    b.HasIndex("GradId");

                    b.ToTable("Klub");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Korisnik", b =>
                {
                    b.Property<int>("KorisnikId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("DatumRodjenja")
                        .HasColumnType("datetime");

                    b.Property<int>("DržavaId")
                        .HasColumnType("int");

                    b.Property<int>("GradId")
                        .HasColumnType("int");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<bool>("IsPremium")
                        .HasColumnType("bit");

                    b.Property<int>("KorisničkiRačunId")
                        .HasColumnType("int");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<int>("UlogaId")
                        .HasColumnType("int");

                    b.HasKey("KorisnikId");

                    b.HasIndex("DržavaId");

                    b.HasIndex("GradId");

                    b.HasIndex("KorisničkiRačunId");

                    b.HasIndex("UlogaId");

                    b.ToTable("Korisnik");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.KorisničkiRačun", b =>
                {
                    b.Property<int>("KorisničkiRačunId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("KorisničkiRačunId");

                    b.ToTable("KorisničkiRačun");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.LigaId", b =>
                {
                    b.Property<int>("LigaId1")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("LigaId")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("LigaId1")
                        .HasName("Pk_LigaId_LigaId");

                    b.ToTable("LigaId");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.LigaKlub", b =>
                {
                    b.Property<int>("LigaKlubId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("LigaId")
                        .HasColumnType("int");

                    b.Property<int>("KlubId")
                        .HasColumnType("int");

                    b.Property<int>("SezonaId")
                        .HasColumnType("int");

                    b.Property<int>("BrojBodova")
                        .HasColumnType("int");

                    b.Property<int>("BrojDatihGolova")
                        .HasColumnType("int");

                    b.Property<int>("BrojPrimljenihGolova")
                        .HasColumnType("int");

                    b.HasKey("LigaKlubId", "LigaId", "KlubId", "SezonaId")
                        .HasName("Pk_LigaKlub_LigaKlubIdLigaIdKlubIdSezonaId");

                    b.HasIndex("KlubId");

                    b.HasIndex("LigaId");

                    b.HasIndex("SezonaId");

                    b.ToTable("LigaKlub");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Match", b =>
                {
                    b.Property<int>("MatchId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime");

                    b.Property<int>("DomacinId")
                        .HasColumnType("int");

                    b.Property<int>("GostId")
                        .HasColumnType("int");

                    b.Property<int>("LigaId")
                        .HasColumnType("int");

                    b.Property<int>("RedniBrojKola")
                        .HasColumnType("int");

                    b.Property<string>("Rezultat")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Stadion")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("MatchId");

                    b.HasIndex("DomacinId");

                    b.HasIndex("GostId");

                    b.HasIndex("LigaId");

                    b.ToTable("Match");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Sezona", b =>
                {
                    b.Property<int>("SezonaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<bool>("Aktivna")
                        .HasColumnType("bit");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("SezonaId");

                    b.ToTable("Sezona");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Statistika", b =>
                {
                    b.Property<int>("StatistikaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("Asistencije")
                        .HasColumnType("int");

                    b.Property<int>("CrveniKartoni")
                        .HasColumnType("int");

                    b.Property<int>("Golovi")
                        .HasColumnType("int");

                    b.Property<int>("ŽutiKartoni")
                        .HasColumnType("int");

                    b.HasKey("StatistikaId");

                    b.ToTable("Statistika");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Transfer", b =>
                {
                    b.Property<int>("TransferId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("BrojGodinaUgovora")
                        .HasColumnType("int");

                    b.Property<int>("Cijena")
                        .HasColumnType("int");

                    b.Property<int>("FudbalerId")
                        .HasColumnType("int");

                    b.Property<int>("KlubId")
                        .HasColumnType("int");

                    b.Property<int>("SezonaId")
                        .HasColumnType("int");

                    b.HasKey("TransferId");

                    b.HasIndex("FudbalerId");

                    b.HasIndex("KlubId");

                    b.HasIndex("SezonaId");

                    b.ToTable("Transfer");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Uloga", b =>
                {
                    b.Property<int>("UlogaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Deskripcija")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("UlogaId");

                    b.ToTable("Uloga");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Fudbaler", b =>
                {
                    b.HasOne("BHFudbal.BHFudbalDatabase.Grad", "Grad")
                        .WithMany("Fudbalers")
                        .HasForeignKey("GradId")
                        .HasConstraintName("Fk_Grad_Fudbaler_GradId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.Klub", "Klub")
                        .WithMany("Fudbalers")
                        .HasForeignKey("KlubId")
                        .HasConstraintName("Fk_Klub_Fudbaler_KlubId")
                        .IsRequired();

                    b.Navigation("Grad");

                    b.Navigation("Klub");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.FudbalerMatch", b =>
                {
                    b.HasOne("BHFudbal.BHFudbalDatabase.Fudbaler", "Fudbaler")
                        .WithMany("FudbalerMatches")
                        .HasForeignKey("FudbalerId")
                        .HasConstraintName("Fk_Fudbaler_FudbalerMatch_FudbalerId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.Match", "Match")
                        .WithMany("FudbalerMatches")
                        .HasForeignKey("MatchId")
                        .HasConstraintName("Fk_Match_FudbalerMatch_MatchId")
                        .IsRequired();

                    b.Navigation("Fudbaler");

                    b.Navigation("Match");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.FudbalerStatistika", b =>
                {
                    b.HasOne("BHFudbal.BHFudbalDatabase.Fudbaler", "Fudbaler")
                        .WithMany("FudbalerStatistikas")
                        .HasForeignKey("FudbalerId")
                        .HasConstraintName("Fk_Fudbaler_FudbalerStatistika_FudbalerId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.Sezona", "Sezona")
                        .WithMany("FudbalerStatistikas")
                        .HasForeignKey("SezonaId")
                        .HasConstraintName("Fk_Sezona_FudbalerStatistika_SezonaId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.Statistika", "Statistika")
                        .WithMany("FudbalerStatistikas")
                        .HasForeignKey("StatistikaId")
                        .HasConstraintName("Fk_Statistika_FudbalerStatistika_StatistikaId")
                        .IsRequired();

                    b.Navigation("Fudbaler");

                    b.Navigation("Sezona");

                    b.Navigation("Statistika");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Klub", b =>
                {
                    b.HasOne("BHFudbal.BHFudbalDatabase.Grad", "Grad")
                        .WithMany("Klubs")
                        .HasForeignKey("GradId")
                        .HasConstraintName("Fk_Grad_Klub_GradId")
                        .IsRequired();

                    b.Navigation("Grad");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Korisnik", b =>
                {
                    b.HasOne("BHFudbal.BHFudbalDatabase.Država", "Država")
                        .WithMany("Korisniks")
                        .HasForeignKey("DržavaId")
                        .HasConstraintName("Fk_Država_Korisnik_DržavaId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.Grad", "Grad")
                        .WithMany("Korisniks")
                        .HasForeignKey("GradId")
                        .HasConstraintName("Fk_Grad_Korisnik_GradId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.KorisničkiRačun", "KorisničkiRačun")
                        .WithMany("Korisniks")
                        .HasForeignKey("KorisničkiRačunId")
                        .HasConstraintName("Fk_KorisničkiRačun_Korisnik_KorisničkiRačunId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.Uloga", "Uloga")
                        .WithMany("Korisniks")
                        .HasForeignKey("UlogaId")
                        .HasConstraintName("Fk_Uloga_Korisnik_UlogaId")
                        .IsRequired();

                    b.Navigation("Država");

                    b.Navigation("Grad");

                    b.Navigation("KorisničkiRačun");

                    b.Navigation("Uloga");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.LigaKlub", b =>
                {
                    b.HasOne("BHFudbal.BHFudbalDatabase.Klub", "Klub")
                        .WithMany("LigaKlubs")
                        .HasForeignKey("KlubId")
                        .HasConstraintName("Fk_Klub_LigaKlub_KlubId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.LigaId", "Liga")
                        .WithMany("LigaKlubs")
                        .HasForeignKey("LigaId")
                        .HasConstraintName("Fk_LigaId_LigaKlub_LigaId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.Sezona", "Sezona")
                        .WithMany("LigaKlubs")
                        .HasForeignKey("SezonaId")
                        .HasConstraintName("Fk_Sezona_LigaKlub_SezonaId")
                        .IsRequired();

                    b.Navigation("Klub");

                    b.Navigation("Liga");

                    b.Navigation("Sezona");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Match", b =>
                {
                    b.HasOne("BHFudbal.BHFudbalDatabase.Klub", "Domacin")
                        .WithMany("MatchDomacins")
                        .HasForeignKey("DomacinId")
                        .HasConstraintName("Fk_Klub_Match_DomacinId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.Klub", "Gost")
                        .WithMany("MatchGosts")
                        .HasForeignKey("GostId")
                        .HasConstraintName("Fk_Klub_Match_GostId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.LigaId", "Liga")
                        .WithMany("Matches")
                        .HasForeignKey("LigaId")
                        .HasConstraintName("Fk_LigaId_Match_LigaId")
                        .IsRequired();

                    b.Navigation("Domacin");

                    b.Navigation("Gost");

                    b.Navigation("Liga");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Transfer", b =>
                {
                    b.HasOne("BHFudbal.BHFudbalDatabase.Fudbaler", "Fudbaler")
                        .WithMany("Transfers")
                        .HasForeignKey("FudbalerId")
                        .HasConstraintName("Fk_Fudbaler_Transfer_FudbalerId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.Klub", "Klub")
                        .WithMany("Transfers")
                        .HasForeignKey("KlubId")
                        .HasConstraintName("Fk_Klub_Transfer_KlubId")
                        .IsRequired();

                    b.HasOne("BHFudbal.BHFudbalDatabase.Sezona", "Sezona")
                        .WithMany("Transfers")
                        .HasForeignKey("SezonaId")
                        .HasConstraintName("Fk_Sezona_Transfer_SezonaId")
                        .IsRequired();

                    b.Navigation("Fudbaler");

                    b.Navigation("Klub");

                    b.Navigation("Sezona");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Država", b =>
                {
                    b.Navigation("Korisniks");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Fudbaler", b =>
                {
                    b.Navigation("FudbalerMatches");

                    b.Navigation("FudbalerStatistikas");

                    b.Navigation("Transfers");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Grad", b =>
                {
                    b.Navigation("Fudbalers");

                    b.Navigation("Klubs");

                    b.Navigation("Korisniks");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Klub", b =>
                {
                    b.Navigation("Fudbalers");

                    b.Navigation("LigaKlubs");

                    b.Navigation("MatchDomacins");

                    b.Navigation("MatchGosts");

                    b.Navigation("Transfers");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.KorisničkiRačun", b =>
                {
                    b.Navigation("Korisniks");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.LigaId", b =>
                {
                    b.Navigation("LigaKlubs");

                    b.Navigation("Matches");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Match", b =>
                {
                    b.Navigation("FudbalerMatches");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Sezona", b =>
                {
                    b.Navigation("FudbalerStatistikas");

                    b.Navigation("LigaKlubs");

                    b.Navigation("Transfers");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Statistika", b =>
                {
                    b.Navigation("FudbalerStatistikas");
                });

            modelBuilder.Entity("BHFudbal.BHFudbalDatabase.Uloga", b =>
                {
                    b.Navigation("Korisniks");
                });
#pragma warning restore 612, 618
        }
    }
}
