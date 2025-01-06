namespace ProductsCategoriesMangSystem.Models
{
    public class AuditLog
    {
        public Guid Id { get; set; }
        public DateTime Timestamp { get; set; }
        public string Action { get; set; }
        public string EntityName { get; set; }
        public Guid EntityId { get; set; }
        public string? OldValues { get; set; }
        public string? NewValues { get; set; }
        public string? UserId { get; set; }
        public string? IPAddress { get; set; }
    }
}
