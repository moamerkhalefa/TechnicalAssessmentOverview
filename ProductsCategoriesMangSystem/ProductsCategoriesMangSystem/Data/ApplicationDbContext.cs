using Microsoft.EntityFrameworkCore;
using ProductsCategoriesMangSystem.Models;

namespace ProductsCategoriesMangSystem.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) {
            // Disable Lazy Loading
            ChangeTracker.LazyLoadingEnabled = false;
        }

        public DbSet<Category> Categories { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<AuditLog> AuditLogs { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new Configurations.CategoryConfiguration());
        }
    }
}
