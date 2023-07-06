using AirRowingBackend.Entities;
using AirRowingBackend.Helpers;
using Microsoft.EntityFrameworkCore;
using System.Configuration;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// ≈‰÷√øÁ”Ú
builder.Services.AddCors(policy =>
{
    policy.AddPolicy("AllowCorsPolicy", policyBuilder => policyBuilder
            .WithOrigins("http://localhost:3000/")
            .AllowAnyMethod()
            .AllowAnyHeader());
});

// ≈‰÷√ ˝æ›ø‚
var oracleConnectionString = "User Id=test;Password=123456;" +
            "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=47.117.160.47)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=xe)));";
builder.Services.AddDbContext<RowingDb>(options =>
    options.UseOracle(oracleConnectionString));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    app.UseCors("AllowCorsPolicy");
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
