using ProductsCategoriesMangSystem.Enums;
using System.ComponentModel.DataAnnotations;

namespace ProductsCategoriesMangSystem.DTOs
{
    public class LowStockProductsDTO
    {
        public string Name { get; set; }
        public ProductStatus Status { get; set; }
        public int StockQuantity { get; set; }
    }
}
