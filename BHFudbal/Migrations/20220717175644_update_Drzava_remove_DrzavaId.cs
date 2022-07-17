using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class update_Drzava_remove_DrzavaId : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "Fk_Grad_Fudbaler_GradId",
                table: "Fudbaler");

            migrationBuilder.AlterColumn<int>(
                name: "GradId",
                table: "Fudbaler",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_Fudbaler_Grad_GradId",
                table: "Fudbaler",
                column: "GradId",
                principalTable: "Grad",
                principalColumn: "GradId",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Fudbaler_Grad_GradId",
                table: "Fudbaler");

            migrationBuilder.AlterColumn<int>(
                name: "GradId",
                table: "Fudbaler",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "Fk_Grad_Fudbaler_GradId",
                table: "Fudbaler",
                column: "GradId",
                principalTable: "Grad",
                principalColumn: "GradId",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
