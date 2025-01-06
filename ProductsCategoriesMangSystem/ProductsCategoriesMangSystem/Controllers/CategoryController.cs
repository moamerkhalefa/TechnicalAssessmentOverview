using Microsoft.AspNetCore.Mvc;
using ProductsCategoriesMangSystem.DTOs;
using ProductsCategoriesMangSystem.Helpers;
using ProductsCategoriesMangSystem.Models;
using ProductsCategoriesMangSystem.Services;

namespace ProductsCategoriesMangSystem.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryController : ControllerBase
    {
        private readonly ICategoryRepository _repository;
        private readonly IAuditService _auditService;
        public CategoryController(ICategoryRepository repository, IAuditService auditService)
        {
            _repository = repository;
            _auditService = auditService;
        }
        [HttpPost("CreateCategory")]
        public async Task<IActionResult> Create(CreateCategoryDTO dto)
        {
            var category = new Category
            {
                Id = Guid.NewGuid(),
                Name = dto.Name,
                Description = dto.Description,
                ParentCategoryId = dto.ParentCategoryId,
                Status = dto.Status,
                CreatedDate = DateTime.UtcNow,
                UpdatedDate = DateTime.UtcNow
            };
            await _repository.AddAsync(category);
            await _auditService.LogChangeAsync("Create", nameof(Category), category.Id, null,
                $"Name: {category.Name}, Description: {category.Description},Parent: {category.ParentCategoryId}, Status: {category.Status}");
            return Ok(ApiResponseHelper.CreateResponse<object>(true, 201, "Category created successfully"));
        }
        [HttpGet("GetAllCategories")]
        public async Task<IActionResult> GetAll()
        {
            var categories = await _repository.GetAllAsync();
            return Ok(ApiResponseHelper.CreateResponse(true, 200, "", categories));
        }
        [HttpGet("GetCategory/{id}")]
        public async Task<IActionResult> Get(Guid id)
        {
            var category = await _repository.GetByIdAsync(id);
            if (category == null)
                return NotFound(ApiResponseHelper.CreateResponse<object>(false, 404, "Category not found"));
            return Ok(ApiResponseHelper.CreateResponse(true, 200, "", category));
        }
        [HttpPut("UpdateCategory")]
        public async Task<IActionResult> Update(UpdateCategoryDTO dto)
        {
            var category = await _repository.GetByIdAsync(dto.Id);
            if (category == null)
                return NotFound(ApiResponseHelper.CreateResponse<object>(false, 404, "Category not found"));
            var oldValues = $"Name: {category.Name}, Description: {category.Description},Parent: {category.ParentCategoryId}, Status: {category.Status}";
            category.Name = dto.Name;
            category.Description = dto.Description;
            category.Status = dto.Status;
            category.ParentCategoryId = dto.ParentCategoryId;
            category.UpdatedDate = DateTime.UtcNow;
            await _repository.UpdateAsync(category);
            var newValues = $"Name: {dto.Name}, Description: {dto.Description},Parent: {dto.ParentCategoryId}, Status: {dto.Status}";
            await _auditService.LogChangeAsync("Update", nameof(Category), category.Id, oldValues, newValues);
            return Ok(ApiResponseHelper.CreateResponse<object>(true, 200, "Category updated successfully"));
        }
        [HttpDelete("DeleteCategory/{id}")]
        public async Task<IActionResult> Delete(Guid id)
        {
            var category = await _repository.GetByIdAsync(id);
            if (category == null)
                return NotFound(ApiResponseHelper.CreateResponse<object>(false, 404, "Category not found"));
            await _repository.DeleteAsync(id);
            var oldValues = $"Name: {category.Name}, Description: {category.Description},Parent: {category.ParentCategoryId}, Status: {category.Status}";
            await _auditService.LogChangeAsync("Delete", nameof(Category), category.Id, oldValues, null);
            return Ok(ApiResponseHelper.CreateResponse<object>(true, 200, "Category deleted successfully"));
        }
        [HttpGet("GetCategoryLog/{id}")]
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
