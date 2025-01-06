using ProductsCategoriesMangSystem.Data;
using ProductsCategoriesMangSystem.Models;
using System;

namespace ProductsCategoriesMangSystem.Services
{
    public class AuditService: IAuditService
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogger<AuditService> _logger;

        public AuditService(ApplicationDbContext context, ILogger<AuditService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task LogChangeAsync(string action, string entityName, Guid entityId, string? oldValues = null, string? newValues = null, string? userId = null, string? ipAddress = null)
        {
            var auditLog = new AuditLog
            {
                Timestamp = DateTime.Now,
                Action = action,
                EntityName = entityName,
                EntityId = entityId,
                OldValues = oldValues,
                NewValues = newValues,
                UserId = userId,
                IPAddress = ipAddress
            };

            await _context.AuditLogs.AddAsync(auditLog);
            await _context.SaveChangesAsync();

            _logger.LogInformation("Audit Log: {@AuditLog}", auditLog);
        }
    }
}