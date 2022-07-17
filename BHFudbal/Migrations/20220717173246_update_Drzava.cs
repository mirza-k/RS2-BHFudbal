using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class update_Drzava : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "DrzavaId",
                table: "Fudbaler",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Fudbaler_DrzavaId",
                table: "Fudbaler",
                column: "DrzavaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Fudbaler_Država_DrzavaId",
                table: "Fudbaler",
                column: "DrzavaId",
                principalTable: "Država",
                principalColumn: "DržavaId",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Fudbaler_Država_DrzavaId",
                table: "Fudbaler");

            migrationBuilder.DropIndex(
                name: "IX_Fudbaler_DrzavaId",
                table: "Fudbaler");

            migrationBuilder.DropColumn(
                name: "DrzavaId",
                table: "Fudbaler");
        }
    }
}
