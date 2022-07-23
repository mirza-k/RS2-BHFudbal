using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class update_Transfer : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "StariKlubId",
                table: "Transfer",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Transfer_StariKlubId",
                table: "Transfer",
                column: "StariKlubId");

            migrationBuilder.AddForeignKey(
                name: "FK_Transfer_Klub_StariKlubId",
                table: "Transfer",
                column: "StariKlubId",
                principalTable: "Klub",
                principalColumn: "KlubId",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Transfer_Klub_StariKlubId",
                table: "Transfer");

            migrationBuilder.DropIndex(
                name: "IX_Transfer_StariKlubId",
                table: "Transfer");

            migrationBuilder.DropColumn(
                name: "StariKlubId",
                table: "Transfer");
        }
    }
}
