using AirRowingBackend.Entities;
using AirRowingBackend.Helpers;
using Microsoft.EntityFrameworkCore;
using System.Configuration;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Microsoft.Extensions.FileProviders;



var builder = WebApplication.CreateBuilder(args);
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes("YourSecretKeyHerePleaseMakeSureItIsAtLeast32CharactersLong")),
        ValidateIssuer = false,
        ValidateAudience = false,
    };
});


// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// 配置跨域
builder.Services.AddCors(policy =>
{
    policy.AddPolicy("AllowCorsPolicy", policyBuilder => policyBuilder
            .WithOrigins("http://localhost:3000/")
            .AllowAnyMethod()
            .AllowAnyHeader());
});

// 配置数据库
var oracleConnectionString = "User Id=test;Password=123456;" +
            "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=47.117.160.47)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=xe)));";
builder.Services.AddDbContext<RowingDb>(options =>
    options.UseOracle(oracleConnectionString));
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
else
{
    app.UseStaticFiles();
    app.UseStatusCodePages(new StatusCodePagesOptions
    {
        HandleAsync = context =>
        {
            var response = context.HttpContext.Response;
            if (response.StatusCode == 404)
            {
                response.Redirect("/index.html"); // 重定向到自定义的404错误页面
            }
            return Task.CompletedTask;
        }
    });
}

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
