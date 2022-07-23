using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class newTable_TransferHistory : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "TransferHistories",
                columns: table => new
                {
                    TransferHistoryId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    StariKlubId = table.Column<int>(type: "int", nullable: false),
                    NoviKlubId = table.Column<int>(type: "int", nullable: false),
                    FudbalerId = table.Column<int>(type: "int", nullable: false),
                    SezonaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TransferHistories", x => x.TransferHistoryId);
                    table.ForeignKey(
                        name: "FK_TransferHistories_Fudbaler_FudbalerId",
                        column: x => x.FudbalerId,
                        principalTable: "Fudbaler",
                        principalColumn: "FudbalerId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_TransferHistories_Klub_NoviKlubId",
                        column: x => x.NoviKlubId,
                        principalTable: "Klub",
                        principalColumn: "KlubId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_TransferHistories_Klub_StariKlubId",
                        column: x => x.StariKlubId,
                        principalTable: "Klub",
                        principalColumn: "KlubId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_TransferHistories_Sezona_SezonaId",
                        column: x => x.SezonaId,
                        principalTable: "Sezona",
                        principalColumn: "SezonaId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_TransferHistories_FudbalerId",
                table: "TransferHistories",
                column: "FudbalerId");

            migrationBuilder.CreateIndex(
                name: "IX_TransferHistories_NoviKlubId",
                table: "TransferHistories",
                column: "NoviKlubId");

            migrationBuilder.CreateIndex(
                name: "IX_TransferHistories_SezonaId",
                table: "TransferHistories",
                column: "SezonaId");

            migrationBuilder.CreateIndex(
                name: "IX_TransferHistories_StariKlubId",
                table: "TransferHistories",
                column: "StariKlubId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TransferHistories");
        }
    }
}
