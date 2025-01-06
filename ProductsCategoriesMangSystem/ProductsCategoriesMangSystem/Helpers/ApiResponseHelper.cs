using ProductsCategoriesMangSystem.Shared;

namespace ProductsCategoriesMangSystem.Helpers
{
    public static class ApiResponseHelper
    {
        public static ApiResponse<T> CreateResponse<T>(bool isSuccess, int statusCode, string message, T data = default)
        {
            return new ApiResponse<T>
            {
                IsSuccess = isSuccess,
                StatusCode = statusCode,
                Message = message,
                Data = data
            };
        }
    }
}
