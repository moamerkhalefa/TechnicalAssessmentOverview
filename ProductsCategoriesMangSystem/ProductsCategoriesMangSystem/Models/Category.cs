using ProductsCategoriesMangSystem.Enums;
using System.ComponentModel.DataAnnotations;

namespace ProductsCategoriesMangSystem.Models
{
    public class Category
    {
        public Guid Id { get; set; }
        [Required, MaxLength(50)]
        public string Name { get; set; }
        [MaxLength(200)]
        public string? Description { get; set; }
        public Guid? ParentCategoryId { get; set; }
        public CategoryStatus Status { get; set; } = CategoryStatus.Active;
        public DateTime CreatedDate { get; set; } = DateTime.UtcNow;
        public DateTime? UpdatedDate { get; set; }
        public ICollection<Product> Products { get; set; }
    }
}
