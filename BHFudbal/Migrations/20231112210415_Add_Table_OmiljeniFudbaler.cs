using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class Add_Table_OmiljeniFudbaler : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "OmiljeniFudbalers",
                columns: table => new
                {
                    OmiljeniFudbalerId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FudbalerId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OmiljeniFudbalers", x => x.OmiljeniFudbalerId);
                    table.ForeignKey(
                        name: "FK_OmiljeniFudbalers_Fudbaler_FudbalerId",
                        column: x => x.FudbalerId,
                        principalTable: "Fudbaler",
                        principalColumn: "FudbalerId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_OmiljeniFudbalers_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_OmiljeniFudbalers_FudbalerId",
                table: "OmiljeniFudbalers",
                column: "FudbalerId");

            migrationBuilder.CreateIndex(
                name: "IX_OmiljeniFudbalers_KorisnikId",
                table: "OmiljeniFudbalers",
                column: "KorisnikId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "OmiljeniFudbalers");
        }
    }
}
