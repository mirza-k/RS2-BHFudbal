using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class updateKlubtable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<byte[]>(
                name: "Grb",
                table: "Klub",
                type: "varbinary(max)",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "LigaId",
                table: "Klub",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Klub_LigaId",
                table: "Klub",
                column: "LigaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Klub_LigaId_LigaId",
                table: "Klub",
                column: "LigaId",
                principalTable: "LigaId",
                principalColumn: "LigaId",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Klub_LigaId_LigaId",
                table: "Klub");

            migrationBuilder.DropIndex(
                name: "IX_Klub_LigaId",
                table: "Klub");

            migrationBuilder.DropColumn(
                name: "Grb",
                table: "Klub");

            migrationBuilder.DropColumn(
                name: "LigaId",
                table: "Klub");
        }
    }
}
