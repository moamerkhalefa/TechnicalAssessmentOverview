using ProductsCategoriesMangSystem.Enums;
using System.ComponentModel.DataAnnotations;

namespace ProductsCategoriesMangSystem.DTOs
{
    public class UpdateProductDTO
    {
        [Required]
        public Guid Id { get; set; }
        [Required]
        [MaxLength(100)]
        public string Name { get; set; }
        [Required]
        [MaxLength(500)]
        public string Description { get; set; }
        [Required]
        [Range(0.01, double.MaxValue, ErrorMessage = "Price must be greater than 0.")]
        public decimal Price { get; set; }
        [Required]
        public Guid CategoryId { get; set; }
        [Required]
        public ProductStatus Status { get; set; }
        [Required]
        [Range(0, int.MaxValue, ErrorMessage = "StockQuantity cannot be negative.")]
        public int StockQuantity { get; set; }
        public string? ImageUrl { get; set; }
    }
}
