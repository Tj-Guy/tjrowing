using AirRowingBackend.Entities;
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
            .AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader());
});

var app = builder.Build();

// ≈‰÷√ ˝æ›ø‚
var oracleConnectionString = "User Id=AIR_ROWING;Password=airrowing;" +
            "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=47.117.160.47)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=helowin)));";
builder.Services.AddDbContext<RowingDb>(options =>
{
    options.UseOracle(oracleConnectionString);
});

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
