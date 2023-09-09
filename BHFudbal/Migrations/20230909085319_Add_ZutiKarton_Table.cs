using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class Add_ZutiKarton_Table : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ZutiKartons",
                columns: table => new
                {
                    ZutiKartonId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MatchId = table.Column<int>(type: "int", nullable: false),
                    FudbalerId = table.Column<int>(type: "int", nullable: false),
                    MinutaGola = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ZutiKartons", x => x.ZutiKartonId);
                    table.ForeignKey(
                        name: "FK_ZutiKartons_Fudbaler_FudbalerId",
                        column: x => x.FudbalerId,
                        principalTable: "Fudbaler",
                        principalColumn: "FudbalerId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ZutiKartons_Match_MatchId",
                        column: x => x.MatchId,
                        principalTable: "Match",
                        principalColumn: "MatchId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ZutiKartons_FudbalerId",
                table: "ZutiKartons",
                column: "FudbalerId");

            migrationBuilder.CreateIndex(
                name: "IX_ZutiKartons_MatchId",
                table: "ZutiKartons",
                column: "MatchId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ZutiKartons");
        }
    }
}
