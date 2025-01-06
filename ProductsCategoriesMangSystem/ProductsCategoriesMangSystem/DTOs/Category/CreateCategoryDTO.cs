using ProductsCategoriesMangSystem.Enums;
using System.ComponentModel.DataAnnotations;

namespace ProductsCategoriesMangSystem.DTOs
{
    public class CreateCategoryDTO
    {
        [Required, MaxLength(50)]
        public string Name { get; set; }
        [MaxLength(200)]
        public string? Description { get; set; }
        public Guid? ParentCategoryId { get; set; }
        public CategoryStatus Status { get; set; }
    }
}
