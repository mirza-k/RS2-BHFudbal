using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class Add_CrveniKarton_Table : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "CrveniKartons",
                columns: table => new
                {
                    CrveniKartonId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MatchId = table.Column<int>(type: "int", nullable: false),
                    FudbalerId = table.Column<int>(type: "int", nullable: false),
                    MinutaKartona = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CrveniKartons", x => x.CrveniKartonId);
                    table.ForeignKey(
                        name: "FK_CrveniKartons_Fudbaler_FudbalerId",
                        column: x => x.FudbalerId,
                        principalTable: "Fudbaler",
                        principalColumn: "FudbalerId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CrveniKartons_Match_MatchId",
                        column: x => x.MatchId,
                        principalTable: "Match",
                        principalColumn: "MatchId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_CrveniKartons_FudbalerId",
                table: "CrveniKartons",
                column: "FudbalerId");

            migrationBuilder.CreateIndex(
                name: "IX_CrveniKartons_MatchId",
                table: "CrveniKartons",
                column: "MatchId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CrveniKartons");
        }
    }
}
