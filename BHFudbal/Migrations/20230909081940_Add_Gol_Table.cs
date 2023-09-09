using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class Add_Gol_Table : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "Fk_Grad_Klub_GradId",
                table: "Klub");

            migrationBuilder.DropForeignKey(
                name: "Fk_KorisničkiRačun_Korisnik_KorisničkiRačunId",
                table: "Korisnik");

            migrationBuilder.CreateTable(
                name: "Gols",
                columns: table => new
                {
                    GolId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MatchId = table.Column<int>(type: "int", nullable: false),
                    FudbalerId = table.Column<int>(type: "int", nullable: false),
                    MinutaGola = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Gols", x => x.GolId);
                    table.ForeignKey(
                        name: "FK_Gols_Fudbaler_FudbalerId",
                        column: x => x.FudbalerId,
                        principalTable: "Fudbaler",
                        principalColumn: "FudbalerId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Gols_Match_MatchId",
                        column: x => x.MatchId,
                        principalTable: "Match",
                        principalColumn: "MatchId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Gols_FudbalerId",
                table: "Gols",
                column: "FudbalerId");

            migrationBuilder.CreateIndex(
                name: "IX_Gols_MatchId",
                table: "Gols",
                column: "MatchId");

            migrationBuilder.AddForeignKey(
                name: "Fk_Grad_Klub_GradId",
                table: "Klub",
                column: "GradId",
                principalTable: "Grad",
                principalColumn: "GradId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "Fk_KorisničkiRačun_Korisnik_KorisničkiRačunId",
                table: "Korisnik",
                column: "KorisničkiRačunId",
                principalTable: "KorisničkiRačun",
                principalColumn: "KorisničkiRačunId",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "Fk_Grad_Klub_GradId",
                table: "Klub");

            migrationBuilder.DropForeignKey(
                name: "Fk_KorisničkiRačun_Korisnik_KorisničkiRačunId",
                table: "Korisnik");

            migrationBuilder.DropTable(
                name: "Gols");

            migrationBuilder.AddForeignKey(
                name: "Fk_Grad_Klub_GradId",
                table: "Klub",
                column: "GradId",
                principalTable: "Grad",
                principalColumn: "GradId",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "Fk_KorisničkiRačun_Korisnik_KorisničkiRačunId",
                table: "Korisnik",
                column: "KorisničkiRačunId",
                principalTable: "KorisničkiRačun",
                principalColumn: "KorisničkiRačunId",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
