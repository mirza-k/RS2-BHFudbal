using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace BHFudbal.BHFudbalDatabase
{
    public partial class BHFudbalDBContext : DbContext
    {
        public BHFudbalDBContext()
        {
        }

        public BHFudbalDBContext(DbContextOptions<BHFudbalDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Država> Državas { get; set; }
        public virtual DbSet<Fudbaler> Fudbalers { get; set; }
        public virtual DbSet<FudbalerMatch> FudbalerMatches { get; set; }
        public virtual DbSet<FudbalerStatistika> FudbalerStatistikas { get; set; }
        public virtual DbSet<Grad> Grads { get; set; }
        public virtual DbSet<Klub> Klubs { get; set; }
        public virtual DbSet<Korisnik> Korisniks { get; set; }
        public virtual DbSet<KorisničkiRačun> KorisničkiRačuns { get; set; }
        public virtual DbSet<LigaId> LigaIds { get; set; }
        public virtual DbSet<LigaKlub> LigaKlubs { get; set; }
        public virtual DbSet<Match> Matches { get; set; }
        public virtual DbSet<Sezona> Sezonas { get; set; }
        public virtual DbSet<Statistika> Statistikas { get; set; }
        public virtual DbSet<Transfer> Transfers { get; set; }
        public virtual DbSet<Uloga> Ulogas { get; set; }
        public virtual DbSet<Gol> Gols{ get; set; }
        public virtual DbSet<ZutiKarton> ZutiKartons{ get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<Država>(entity =>
            {
                entity.ToTable("Država");

                entity.Property(e => e.Naziv)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Fudbaler>(entity =>
            {
                entity.ToTable("Fudbaler");

                entity.Property(e => e.DatumRodjenja).HasColumnType("datetime");

                entity.Property(e => e.Ime)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.JačaNoga)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Prezime)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Težina)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Visina)
                    .IsRequired()
                    .HasMaxLength(50);

                //entity.HasOne(d => d.Grad)
                //    .WithMany(p => p.Fudbalers)
                //    .HasForeignKey(d => d.GradId)
                //    .OnDelete(DeleteBehavior.ClientSetNull)
                //    .HasConstraintName("Fk_Grad_Fudbaler_GradId");

                entity.HasOne(d => d.Klub)
                    .WithMany(p => p.Fudbalers)
                    .HasForeignKey(d => d.KlubId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Klub_Fudbaler_KlubId");
            });

            modelBuilder.Entity<FudbalerMatch>(entity =>
            {
                entity.ToTable("FudbalerMatch");

                entity.HasOne(d => d.Fudbaler)
                    .WithMany(p => p.FudbalerMatches)
                    .HasForeignKey(d => d.FudbalerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Fudbaler_FudbalerMatch_FudbalerId");

                entity.HasOne(d => d.Match)
                    .WithMany(p => p.FudbalerMatches)
                    .HasForeignKey(d => d.MatchId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Match_FudbalerMatch_MatchId");
            });

            modelBuilder.Entity<FudbalerStatistika>(entity =>
            {
                entity.ToTable("FudbalerStatistika");

                entity.HasOne(d => d.Fudbaler)
                    .WithMany(p => p.FudbalerStatistikas)
                    .HasForeignKey(d => d.FudbalerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Fudbaler_FudbalerStatistika_FudbalerId");

                entity.HasOne(d => d.Sezona)
                    .WithMany(p => p.FudbalerStatistikas)
                    .HasForeignKey(d => d.SezonaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Sezona_FudbalerStatistika_SezonaId");

                entity.HasOne(d => d.Statistika)
                    .WithMany(p => p.FudbalerStatistikas)
                    .HasForeignKey(d => d.StatistikaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Statistika_FudbalerStatistika_StatistikaId");
            });

            modelBuilder.Entity<Grad>(entity =>
            {
                entity.ToTable("Grad");

                entity.Property(e => e.Naziv)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Klub>(entity =>
            {
                entity.ToTable("Klub");

                entity.Property(e => e.DatumOsnivanja).HasColumnType("datetime");

                entity.Property(e => e.Nadimak).HasMaxLength(50);

                entity.Property(e => e.Naziv)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Grad)
                    .WithMany(p => p.Klubs)
                    .HasForeignKey(d => d.GradId)
                    .HasConstraintName("Fk_Grad_Klub_GradId");
            });

            modelBuilder.Entity<Korisnik>(entity =>
            {
                entity.ToTable("Korisnik");

                entity.Property(e => e.DatumRodjenja).HasColumnType("datetime");

                entity.Property(e => e.Ime)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Prezime)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Država)
                    .WithMany(p => p.Korisniks)
                    .HasForeignKey(d => d.DržavaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Država_Korisnik_DržavaId");

                entity.HasOne(d => d.Grad)
                    .WithMany(p => p.Korisniks)
                    .HasForeignKey(d => d.GradId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Grad_Korisnik_GradId");

                entity.HasOne(d => d.KorisničkiRačun)
                    .WithMany(p => p.Korisniks)
                    .HasForeignKey(d => d.KorisničkiRačunId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("Fk_KorisničkiRačun_Korisnik_KorisničkiRačunId");

                entity.HasOne(d => d.Uloga)
                    .WithMany(p => p.Korisniks)
                    .HasForeignKey(d => d.UlogaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Uloga_Korisnik_UlogaId");
            });

            modelBuilder.Entity<KorisničkiRačun>(entity =>
            {
                entity.ToTable("KorisničkiRačun");

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Username)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<LigaId>(entity =>
            {
                entity.HasKey(e => e.LigaId1)
                    .HasName("Pk_LigaId_LigaId");

                entity.ToTable("LigaId");

                entity.Property(e => e.LigaId1).HasColumnName("LigaId");

                entity.Property(e => e.Naziv)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<LigaKlub>(entity =>
            {
                entity.HasKey(e => new { e.LigaKlubId, e.LigaId, e.KlubId, e.SezonaId })
                    .HasName("Pk_LigaKlub_LigaKlubIdLigaIdKlubIdSezonaId");

                entity.ToTable("LigaKlub");

                entity.Property(e => e.LigaKlubId).ValueGeneratedOnAdd();

                entity.HasOne(d => d.Klub)
                    .WithMany(p => p.LigaKlubs)
                    .HasForeignKey(d => d.KlubId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Klub_LigaKlub_KlubId");

                entity.HasOne(d => d.Liga)
                    .WithMany(p => p.LigaKlubs)
                    .HasForeignKey(d => d.LigaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_LigaId_LigaKlub_LigaId");

                entity.HasOne(d => d.Sezona)
                    .WithMany(p => p.LigaKlubs)
                    .HasForeignKey(d => d.SezonaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Sezona_LigaKlub_SezonaId");
            });

            modelBuilder.Entity<Match>(entity =>
            {
                entity.ToTable("Match");

                entity.Property(e => e.Datum).HasColumnType("datetime");

                entity.Property(e => e.Rezultat)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Stadion)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Domacin)
                    .WithMany(p => p.MatchDomacins)
                    .HasForeignKey(d => d.DomacinId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Klub_Match_DomacinId");

                entity.HasOne(d => d.Gost)
                    .WithMany(p => p.MatchGosts)
                    .HasForeignKey(d => d.GostId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Klub_Match_GostId");

                entity.HasOne(d => d.Liga)
                    .WithMany(p => p.Matches)
                    .HasForeignKey(d => d.LigaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_LigaId_Match_LigaId");
            });

            modelBuilder.Entity<Sezona>(entity =>
            {
                entity.ToTable("Sezona");

                entity.Property(e => e.Naziv)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Statistika>(entity =>
            {
                entity.ToTable("Statistika");
            });

            modelBuilder.Entity<Transfer>(entity =>
            {
                entity.ToTable("Transfer");

                entity.HasOne(d => d.Fudbaler)
                    .WithMany(p => p.Transfers)
                    .HasForeignKey(d => d.FudbalerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Fudbaler_Transfer_FudbalerId");

                entity.HasOne(d => d.Klub)
                    .WithMany(p => p.Transfers)
                    .HasForeignKey(d => d.KlubId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Klub_Transfer_KlubId");

                entity.HasOne(d => d.Sezona)
                    .WithMany(p => p.Transfers)
                    .HasForeignKey(d => d.SezonaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Fk_Sezona_Transfer_SezonaId");
            });

            modelBuilder.Entity<Uloga>(entity =>
            {
                entity.ToTable("Uloga");

                entity.Property(e => e.Deskripcija)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Naziv)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
