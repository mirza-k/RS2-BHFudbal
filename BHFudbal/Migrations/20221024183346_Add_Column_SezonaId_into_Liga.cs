using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class Add_Column_SezonaId_into_Liga : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "SezonaId",
                table: "LigaId",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_LigaId_SezonaId",
                table: "LigaId",
                column: "SezonaId");

            migrationBuilder.AddForeignKey(
                name: "FK_LigaId_Sezona_SezonaId",
                table: "LigaId",
                column: "SezonaId",
                principalTable: "Sezona",
                principalColumn: "SezonaId",
                onDelete: ReferentialAction.NoAction);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_LigaId_Sezona_SezonaId",
                table: "LigaId");

            migrationBuilder.DropIndex(
                name: "IX_LigaId_SezonaId",
                table: "LigaId");

            migrationBuilder.DropColumn(
                name: "SezonaId",
                table: "LigaId");
        }
    }
}
