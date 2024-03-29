﻿using Microsoft.EntityFrameworkCore.Migrations;

namespace BHFudbal.Migrations
{
    public partial class Add_column_Rating : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Rating",
                table: "OmiljeniFudbalers",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Rating",
                table: "OmiljeniFudbalers");
        }
    }
}
