using Microsoft.EntityFrameworkCore;
using ProductsCategoriesMangSystem.Data;
using ProductsCategoriesMangSystem.DTOs;
using ProductsCategoriesMangSystem.Enums;
using ProductsCategoriesMangSystem.Models;

namespace ProductsCategoriesMangSystem.Repositories
{
    public class DashboardRepository : IDashboardRepository
    {
        private readonly ApplicationDbContext _context;

        public DashboardRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<CountsDTO> GetCountsAsync()
        {
            IQueryable<Product> productsQuery = _context.Products;
            var totalProducts = await productsQuery.CountAsync();
            var activeProducts = await productsQuery.Where(p => p.Status == ProductStatus.Active).CountAsync();

            IQueryable<Category> categoriesQuery = _context.Categories;
            var totalCategories = await categoriesQuery.CountAsync();
            var activeCategories = await categoriesQuery.Where(p => p.Status == CategoryStatus.Active).CountAsync();

            var counts = new CountsDTO
            {
                TotalProducts = totalProducts,
                ActiveProducts = activeProducts,
                TotalCategories = totalCategories,
                ActiveCategories = activeCategories,
            };
            return counts;
        }

        public async Task<List<CategoryProductsCountDTO>> GetCategoryProductsCountAsync()
        {
            var categoryProductsCount = await _context.Categories.Include(c => c.Products) 
                .Select(c => new CategoryProductsCountDTO
                {
                   Name = c.Name,
                   Status = c.Status,
                   ProductsCount = c.Products.Count()
                }).ToListAsync();
            return categoryProductsCount;
        }

        public async Task<List<LowStockProductsDTO>> GetLowStockProductsAsync()
        {
            var lowStockProducts = await _context.Products.OrderBy(p => p.StockQuantity).Take(10)
                .Select(c => new LowStockProductsDTO
                {
                    Name = c.Name,
                    Status = c.Status,
                    StockQuantity = c.StockQuantity
                }).ToListAsync();
            return lowStockProducts;
        }

        public async Task<IEnumerable<AuditLog>> GetRecentActivitiesLogAsync()
        {
            return await _context.AuditLogs.OrderByDescending(a => a.Timestamp).Take(20).ToListAsync();
        }
    }
}
