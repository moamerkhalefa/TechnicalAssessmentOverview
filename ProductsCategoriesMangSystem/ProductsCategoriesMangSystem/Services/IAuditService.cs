namespace ProductsCategoriesMangSystem.Services
{
    public interface IAuditService
    {
        Task LogChangeAsync(string action, string entityName, Guid entityId, string? oldValues = null, string? newValues = null, string? userId = null, string? ipAddress = null);
    }
}
