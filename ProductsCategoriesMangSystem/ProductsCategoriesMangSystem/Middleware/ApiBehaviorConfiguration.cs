using Microsoft.AspNetCore.Mvc;
using System.Net;

namespace ProductsCategoriesMangSystem.Middleware
{
    public static class ApiBehaviorConfiguration
    {
        public static void ConfigureApiBehavior(ApiBehaviorOptions options)
        {
            options.InvalidModelStateResponseFactory = context =>
            {
                // Extract field-specific errors in a user-friendly format
                var errors = context.ModelState
                    .Where(x => x.Value.Errors.Count > 0)
                    .ToDictionary(
                        kvp => kvp.Key, // Field name
                        kvp => kvp.Value.Errors.Select(e => e.ErrorMessage).ToArray() // Error messages
                    );
                var userFriendlyMessage = "Some fields contain invalid values. Please review your input.";
                var response = new
                {
                    isSuccess = false,
                    statusCode = (int)HttpStatusCode.BadRequest,
                    message = userFriendlyMessage,
                    data = errors 
                };
                return new BadRequestObjectResult(response);
            };
        }
    }
}
