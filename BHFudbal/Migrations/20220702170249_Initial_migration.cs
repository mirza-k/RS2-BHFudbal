using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class Initial_migration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Država",
                columns: table => new
                {
                    DržavaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Država", x => x.DržavaId);
                });

            migrationBuilder.CreateTable(
                name: "Grad",
                columns: table => new
                {
                    GradId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Grad", x => x.GradId);
                });

            migrationBuilder.CreateTable(
                name: "KorisničkiRačun",
                columns: table => new
                {
                    KorisničkiRačunId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Username = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Password = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisničkiRačun", x => x.KorisničkiRačunId);
                });

            migrationBuilder.CreateTable(
                name: "LigaId",
                columns: table => new
                {
                    LigaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("Pk_LigaId_LigaId", x => x.LigaId);
                });

            migrationBuilder.CreateTable(
                name: "Sezona",
                columns: table => new
                {
                    SezonaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Aktivna = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Sezona", x => x.SezonaId);
                });

            migrationBuilder.CreateTable(
                name: "Statistika",
                columns: table => new
                {
                    StatistikaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Golovi = table.Column<int>(type: "int", nullable: false),
                    Asistencije = table.Column<int>(type: "int", nullable: false),
                    ŽutiKartoni = table.Column<int>(type: "int", nullable: false),
                    CrveniKartoni = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Statistika", x => x.StatistikaId);
                });

            migrationBuilder.CreateTable(
                name: "Uloga",
                columns: table => new
                {
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Deskripcija = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloga", x => x.UlogaId);
                });

            migrationBuilder.CreateTable(
                name: "Klub",
                columns: table => new
                {
                    KlubId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    DatumOsnivanja = table.Column<DateTime>(type: "datetime", nullable: false),
                    Nadimak = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    GradId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Klub", x => x.KlubId);
                    table.ForeignKey(
                        name: "Fk_Grad_Klub_GradId",
                        column: x => x.GradId,
                        principalTable: "Grad",
                        principalColumn: "GradId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    DatumRodjenja = table.Column<DateTime>(type: "datetime", nullable: false),
                    GradId = table.Column<int>(type: "int", nullable: false),
                    UlogaId = table.Column<int>(type: "int", nullable: false),
                    DržavaId = table.Column<int>(type: "int", nullable: false),
                    KorisničkiRačunId = table.Column<int>(type: "int", nullable: false),
                    IsPremium = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik", x => x.KorisnikId);
                    table.ForeignKey(
                        name: "Fk_Država_Korisnik_DržavaId",
                        column: x => x.DržavaId,
                        principalTable: "Država",
                        principalColumn: "DržavaId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_Grad_Korisnik_GradId",
                        column: x => x.GradId,
                        principalTable: "Grad",
                        principalColumn: "GradId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_KorisničkiRačun_Korisnik_KorisničkiRačunId",
                        column: x => x.KorisničkiRačunId,
                        principalTable: "KorisničkiRačun",
                        principalColumn: "KorisničkiRačunId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_Uloga_Korisnik_UlogaId",
                        column: x => x.UlogaId,
                        principalTable: "Uloga",
                        principalColumn: "UlogaId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Fudbaler",
                columns: table => new
                {
                    FudbalerId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Visina = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Težina = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    DatumRodjenja = table.Column<DateTime>(type: "datetime", nullable: false),
                    GradId = table.Column<int>(type: "int", nullable: false),
                    KlubId = table.Column<int>(type: "int", nullable: false),
                    JačaNoga = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Fudbaler", x => x.FudbalerId);
                    table.ForeignKey(
                        name: "Fk_Grad_Fudbaler_GradId",
                        column: x => x.GradId,
                        principalTable: "Grad",
                        principalColumn: "GradId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_Klub_Fudbaler_KlubId",
                        column: x => x.KlubId,
                        principalTable: "Klub",
                        principalColumn: "KlubId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "LigaKlub",
                columns: table => new
                {
                    LigaKlubId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    LigaId = table.Column<int>(type: "int", nullable: false),
                    KlubId = table.Column<int>(type: "int", nullable: false),
                    SezonaId = table.Column<int>(type: "int", nullable: false),
                    BrojBodova = table.Column<int>(type: "int", nullable: false),
                    BrojDatihGolova = table.Column<int>(type: "int", nullable: false),
                    BrojPrimljenihGolova = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("Pk_LigaKlub_LigaKlubIdLigaIdKlubIdSezonaId", x => new { x.LigaKlubId, x.LigaId, x.KlubId, x.SezonaId });
                    table.ForeignKey(
                        name: "Fk_Klub_LigaKlub_KlubId",
                        column: x => x.KlubId,
                        principalTable: "Klub",
                        principalColumn: "KlubId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_LigaId_LigaKlub_LigaId",
                        column: x => x.LigaId,
                        principalTable: "LigaId",
                        principalColumn: "LigaId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_Sezona_LigaKlub_SezonaId",
                        column: x => x.SezonaId,
                        principalTable: "Sezona",
                        principalColumn: "SezonaId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Match",
                columns: table => new
                {
                    MatchId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Stadion = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    DomacinId = table.Column<int>(type: "int", nullable: false),
                    GostId = table.Column<int>(type: "int", nullable: false),
                    LigaId = table.Column<int>(type: "int", nullable: false),
                    Rezultat = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    RedniBrojKola = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Match", x => x.MatchId);
                    table.ForeignKey(
                        name: "Fk_Klub_Match_DomacinId",
                        column: x => x.DomacinId,
                        principalTable: "Klub",
                        principalColumn: "KlubId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_Klub_Match_GostId",
                        column: x => x.GostId,
                        principalTable: "Klub",
                        principalColumn: "KlubId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_LigaId_Match_LigaId",
                        column: x => x.LigaId,
                        principalTable: "LigaId",
                        principalColumn: "LigaId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "FudbalerStatistika",
                columns: table => new
                {
                    FudbalerStatistikaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FudbalerId = table.Column<int>(type: "int", nullable: false),
                    StatistikaId = table.Column<int>(type: "int", nullable: false),
                    SezonaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FudbalerStatistika", x => x.FudbalerStatistikaId);
                    table.ForeignKey(
                        name: "Fk_Fudbaler_FudbalerStatistika_FudbalerId",
                        column: x => x.FudbalerId,
                        principalTable: "Fudbaler",
                        principalColumn: "FudbalerId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_Sezona_FudbalerStatistika_SezonaId",
                        column: x => x.SezonaId,
                        principalTable: "Sezona",
                        principalColumn: "SezonaId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_Statistika_FudbalerStatistika_StatistikaId",
                        column: x => x.StatistikaId,
                        principalTable: "Statistika",
                        principalColumn: "StatistikaId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Transfer",
                columns: table => new
                {
                    TransferId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Cijena = table.Column<int>(type: "int", nullable: false),
                    KlubId = table.Column<int>(type: "int", nullable: false),
                    FudbalerId = table.Column<int>(type: "int", nullable: false),
                    SezonaId = table.Column<int>(type: "int", nullable: false),
                    BrojGodinaUgovora = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Transfer", x => x.TransferId);
                    table.ForeignKey(
                        name: "Fk_Fudbaler_Transfer_FudbalerId",
                        column: x => x.FudbalerId,
                        principalTable: "Fudbaler",
                        principalColumn: "FudbalerId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_Klub_Transfer_KlubId",
                        column: x => x.KlubId,
                        principalTable: "Klub",
                        principalColumn: "KlubId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_Sezona_Transfer_SezonaId",
                        column: x => x.SezonaId,
                        principalTable: "Sezona",
                        principalColumn: "SezonaId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "FudbalerMatch",
                columns: table => new
                {
                    FudbalerMatchId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Golovi = table.Column<int>(type: "int", nullable: false),
                    Asistencije = table.Column<int>(type: "int", nullable: false),
                    ŽutiKarton = table.Column<int>(type: "int", nullable: false),
                    CrveniKarton = table.Column<int>(type: "int", nullable: false),
                    MatchId = table.Column<int>(type: "int", nullable: false),
                    FudbalerId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FudbalerMatch", x => x.FudbalerMatchId);
                    table.ForeignKey(
                        name: "Fk_Fudbaler_FudbalerMatch_FudbalerId",
                        column: x => x.FudbalerId,
                        principalTable: "Fudbaler",
                        principalColumn: "FudbalerId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "Fk_Match_FudbalerMatch_MatchId",
                        column: x => x.MatchId,
                        principalTable: "Match",
                        principalColumn: "MatchId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Fudbaler_GradId",
                table: "Fudbaler",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_Fudbaler_KlubId",
                table: "Fudbaler",
                column: "KlubId");

            migrationBuilder.CreateIndex(
                name: "IX_FudbalerMatch_FudbalerId",
                table: "FudbalerMatch",
                column: "FudbalerId");

            migrationBuilder.CreateIndex(
                name: "IX_FudbalerMatch_MatchId",
                table: "FudbalerMatch",
                column: "MatchId");

            migrationBuilder.CreateIndex(
                name: "IX_FudbalerStatistika_FudbalerId",
                table: "FudbalerStatistika",
                column: "FudbalerId");

            migrationBuilder.CreateIndex(
                name: "IX_FudbalerStatistika_SezonaId",
                table: "FudbalerStatistika",
                column: "SezonaId");

            migrationBuilder.CreateIndex(
                name: "IX_FudbalerStatistika_StatistikaId",
                table: "FudbalerStatistika",
                column: "StatistikaId");

            migrationBuilder.CreateIndex(
                name: "IX_Klub_GradId",
                table: "Klub",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_DržavaId",
                table: "Korisnik",
                column: "DržavaId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_GradId",
                table: "Korisnik",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_KorisničkiRačunId",
                table: "Korisnik",
                column: "KorisničkiRačunId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_UlogaId",
                table: "Korisnik",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_LigaKlub_KlubId",
                table: "LigaKlub",
                column: "KlubId");

            migrationBuilder.CreateIndex(
                name: "IX_LigaKlub_LigaId",
                table: "LigaKlub",
                column: "LigaId");

            migrationBuilder.CreateIndex(
                name: "IX_LigaKlub_SezonaId",
                table: "LigaKlub",
                column: "SezonaId");

            migrationBuilder.CreateIndex(
                name: "IX_Match_DomacinId",
                table: "Match",
                column: "DomacinId");

            migrationBuilder.CreateIndex(
                name: "IX_Match_GostId",
                table: "Match",
                column: "GostId");

            migrationBuilder.CreateIndex(
                name: "IX_Match_LigaId",
                table: "Match",
                column: "LigaId");

            migrationBuilder.CreateIndex(
                name: "IX_Transfer_FudbalerId",
                table: "Transfer",
                column: "FudbalerId");

            migrationBuilder.CreateIndex(
                name: "IX_Transfer_KlubId",
                table: "Transfer",
                column: "KlubId");

            migrationBuilder.CreateIndex(
                name: "IX_Transfer_SezonaId",
                table: "Transfer",
                column: "SezonaId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FudbalerMatch");

            migrationBuilder.DropTable(
                name: "FudbalerStatistika");

            migrationBuilder.DropTable(
                name: "Korisnik");

            migrationBuilder.DropTable(
                name: "LigaKlub");

            migrationBuilder.DropTable(
                name: "Transfer");

            migrationBuilder.DropTable(
                name: "Match");

            migrationBuilder.DropTable(
                name: "Statistika");

            migrationBuilder.DropTable(
                name: "Država");

            migrationBuilder.DropTable(
                name: "KorisničkiRačun");

            migrationBuilder.DropTable(
                name: "Uloga");

            migrationBuilder.DropTable(
                name: "Fudbaler");

            migrationBuilder.DropTable(
                name: "Sezona");

            migrationBuilder.DropTable(
                name: "LigaId");

            migrationBuilder.DropTable(
                name: "Klub");

            migrationBuilder.DropTable(
                name: "Grad");
        }
    }
}
