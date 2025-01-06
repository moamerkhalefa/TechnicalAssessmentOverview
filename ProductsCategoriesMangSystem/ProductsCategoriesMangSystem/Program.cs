using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProductsCategoriesMangSystem.Data;
using ProductsCategoriesMangSystem.Middleware;
using ProductsCategoriesMangSystem.Repositories;
using ProductsCategoriesMangSystem.Services;
using Serilog;
using System.Net;

var builder = WebApplication.CreateBuilder(args);
// Set up Serilog logging to log to a file
Log.Logger = new LoggerConfiguration()
    .MinimumLevel.Error() // Set the minimum log level to 'Error'
    .WriteTo.File("Logs/errors.log", rollingInterval: RollingInterval.Day)
    .CreateLogger();

builder.Logging.ClearProviders();
builder.Logging.AddSerilog();
// Add services to the container.
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddScoped<ICategoryRepository, CategoryRepository>();
builder.Services.AddScoped<IProductRepository, ProductRepository>();
builder.Services.AddScoped<IDashboardRepository, DashboardRepository>();
builder.Services.AddScoped<IAuditService, AuditService>();
builder.Services.AddControllers(options =>
{
    options.Filters.Add(new ProducesResponseTypeAttribute(typeof(object), StatusCodes.Status400BadRequest));
}).ConfigureApiBehaviorOptions(ApiBehaviorConfiguration.ConfigureApiBehavior);

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAnyOrigin", policy =>
    {
        policy.AllowAnyOrigin()  // Allow any origin
              .AllowAnyHeader()  // Allow any headers
              .AllowAnyMethod();  // Allow any HTTP method
    });
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();

app.UseSwaggerUI();

app.UseCors("AllowAnyOrigin");

app.UseMiddleware<CustomErrorMiddleware>();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
