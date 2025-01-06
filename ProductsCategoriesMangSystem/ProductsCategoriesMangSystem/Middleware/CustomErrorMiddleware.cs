using System.Net;
using System.Text.Json;

namespace ProductsCategoriesMangSystem.Middleware
{
    public class CustomErrorMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<CustomErrorMiddleware> _logger;

        public CustomErrorMiddleware(RequestDelegate next, ILogger<CustomErrorMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                // Log the exception at Error level
                _logger.LogError(ex, "An unhandled exception occurred.");
                // Set the response status code and content
                context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                context.Response.ContentType = "application/json";
                var response = new
                {
                    isSuccess = false,
                    statusCode = context.Response.StatusCode,
                    message = ex.Message,
                    data = (object)null
                };
                await context.Response.WriteAsync(JsonSerializer.Serialize(response));
            }
        }
    }
}
