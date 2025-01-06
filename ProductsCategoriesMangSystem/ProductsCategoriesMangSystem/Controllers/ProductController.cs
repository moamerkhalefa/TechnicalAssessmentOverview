using Microsoft.AspNetCore.Mvc;
using ProductsCategoriesMangSystem.DTOs;
using ProductsCategoriesMangSystem.Helpers;
using ProductsCategoriesMangSystem.Models;
using ProductsCategoriesMangSystem.Repositories;
using ProductsCategoriesMangSystem.Services;

namespace ProductsCategoriesMangSystem.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly IProductRepository _repository;
        private readonly IAuditService _auditService;

        public ProductController(IProductRepository repository, IAuditService auditService)
        {
            _repository = repository;
            _auditService = auditService;
        }

        // Create Product
        [HttpPost("CreateProduct")]
        public async Task<IActionResult> Create(CreateProductDTO dto)
        {
            var product = new Product
            {
                Id = Guid.NewGuid(),
                Name = dto.Name,
                Description = dto.Description,
                Price = dto.Price,
                CategoryId = dto.CategoryId,
                Status = dto.Status,
                StockQuantity = dto.StockQuantity,
                ImageUrl = dto.ImageUrl,
                CreatedDate = DateTime.UtcNow,
                UpdatedDate = DateTime.UtcNow
            };

            await _repository.AddAsync(product);
            await _auditService.LogChangeAsync("Create", nameof(Product), product.Id, null,
                $"Name: {product.Name}, Description: {product.Description}, Price: {product.Price}, CategoryId: {product.CategoryId}, Quantity: {product.StockQuantity}, Status: {product.Status}, Image: {product.ImageUrl}");

            return Ok(ApiResponseHelper.CreateResponse<object>(true, 201, "Product created successfully"));
        }

        // Get all Products
        [HttpGet("GetAllProducts")]
        public async Task<IActionResult> GetAll()
        {
            var products = await _repository.GetAllAsync();
            return Ok(ApiResponseHelper.CreateResponse(true, 200, "", products));
        }

        // Get Product by Id
        [HttpGet("GetProduct/{id}")]
        public async Task<IActionResult> Get(Guid id)
        {
            var product = await _repository.GetByIdAsync(id);
            if (product == null)
                return NotFound(ApiResponseHelper.CreateResponse<object>(false, 404, "Product not found"));

            return Ok(ApiResponseHelper.CreateResponse(true, 200, "", product));
        }

        // Update Product
        [HttpPut("UpdateProduct")]
        public async Task<IActionResult> Update(UpdateProductDTO dto)
        {
            var product = await _repository.GetByIdAsync(dto.Id);
            if (product == null)
                return NotFound(ApiResponseHelper.CreateResponse<object>(false, 404, "Product not found"));

            var oldValues = $"Name: {product.Name}, Description: {product.Description}, Price: {product.Price}, Quantity: {product.StockQuantity}, Status: {product.Status}, Image: {product.ImageUrl}";
            product.Name = dto.Name;
            product.Description = dto.Description;
            product.Price = dto.Price;
            product.CategoryId = dto.CategoryId;
            product.Status = dto.Status;
            product.StockQuantity = dto.StockQuantity;
            product.ImageUrl = dto.ImageUrl;
            product.UpdatedDate = DateTime.UtcNow;
            await _repository.UpdateAsync(product);
            var newValues = $"Name: {dto.Name}, Description: {dto.Description}, Price: {dto.Price}, Quantity: {dto.StockQuantity}, Status: {dto.Status}, Image: {dto.ImageUrl}";
            await _auditService.LogChangeAsync("Update", nameof(Product), product.Id, oldValues, newValues);
            return Ok(ApiResponseHelper.CreateResponse<object>(true, 200, "Product updated successfully"));
        }

        // Delete Product
        [HttpDelete("DeleteProduct/{id}")]
        public async Task<IActionResult> Delete(Guid id)
        {
            var product = await _repository.GetByIdAsync(id);
            if (product == null)
                return NotFound(ApiResponseHelper.CreateResponse<object>(false, 404, "Product not found"));

            await _repository.DeleteAsync(id);
            var oldValues = $"Name: {product.Name}, Description: {product.Description}, Price: {product.Price}, Quantity: {product.StockQuantity}, Status: {product.Status}, Image: {product.ImageUrl}";

            await _auditService.LogChangeAsync("Delete", nameof(Product), product.Id, oldValues, null);

            return Ok(ApiResponseHelper.CreateResponse<object>(true, 200, "Product deleted successfully"));
        }

        [HttpGet("GetProductLog/{id}")]
        public async Task<IActionResult> log(Guid id)
        {
            var category = await _repository.GetByIdAsync(id);
            if (category == null)
                return NotFound(ApiResponseHelper.CreateResponse<object>(false, 404, "Category not found"));
            var auditLogs = await _repository.GetLogAsync(id);
            return Ok(ApiResponseHelper.CreateResponse(true, 200, "", auditLogs));
        }
    }
}
