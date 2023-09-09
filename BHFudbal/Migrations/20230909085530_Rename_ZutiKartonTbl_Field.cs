using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class Rename_ZutiKartonTbl_Field : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "MinutaGola",
                table: "ZutiKartons",
                newName: "MinutaKartona");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "MinutaKartona",
                table: "ZutiKartons",
                newName: "MinutaGola");
        }
    }
}
