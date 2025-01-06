using ProductsCategoriesMangSystem.DTOs;
using ProductsCategoriesMangSystem.Models;

public interface IDashboardRepository
{
    Task<CountsDTO> GetCountsAsync();
    Task<List<CategoryProductsCountDTO>> GetCategoryProductsCountAsync();
    Task<List<LowStockProductsDTO>> GetLowStockProductsAsync();
    Task<IEnumerable<AuditLog>> GetRecentActivitiesLogAsync();
}