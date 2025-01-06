
using ProductsCategoriesMangSystem.Enums;

namespace ProductsCategoriesMangSystem.DTOs
{
    public class CategoryProductsCountDTO
    {
        public string Name { get; set; }
        public int? ProductsCount { get; set; }
        public CategoryStatus Status { get; set; }
    }
}
