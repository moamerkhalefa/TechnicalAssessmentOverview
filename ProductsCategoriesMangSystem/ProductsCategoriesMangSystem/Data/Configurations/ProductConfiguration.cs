using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using ProductsCategoriesMangSystem.Models;

namespace ProductsCategoriesMangSystem.Data.Configurations
{
    public class ProductConfiguration : IEntityTypeConfiguration<Product>
    {
        public void Configure(EntityTypeBuilder<Product> builder)
        {
            builder.HasKey(p => p.Id);

            builder.Property(p => p.Name)
                   .IsRequired()
                   .HasMaxLength(100);

            builder.Property(p => p.Description)
                   .IsRequired()
                   .HasMaxLength(500);

            builder.Property(p => p.Price)
                   .IsRequired()
                   .HasColumnType("decimal(18,2)");

            builder.Property(p => p.Status)
                   .IsRequired();

            builder.Property(p => p.StockQuantity)
                   .IsRequired()
                   .HasDefaultValue(0);

            builder.Property(p => p.ImageUrl)
                   .HasMaxLength(500);

            builder.HasOne(p => p.Category)
                   .WithMany(c => c.Products)
                   .HasForeignKey(p => p.CategoryId)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.Property(p => p.CreatedDate)
                   .IsRequired()
                   .HasDefaultValueSql("GETDATE()");
        }
    }
}
