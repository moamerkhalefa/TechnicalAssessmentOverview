using Microsoft.AspNetCore.Mvc;
using ProductsCategoriesMangSystem.DTOs;
using ProductsCategoriesMangSystem.Helpers;
using ProductsCategoriesMangSystem.Models;
using ProductsCategoriesMangSystem.Services;

namespace ProductsCategoriesMangSystem.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DashboardController : ControllerBase
    {
        private readonly IDashboardRepository _repository;
        public DashboardController(IDashboardRepository repository)
        {
            _repository = repository;
        }
        [HttpGet("GetCounts")]
        public async Task<IActionResult> GetCounts()
        {
            var counts = await _repository.GetCountsAsync();
            return Ok(ApiResponseHelper.CreateResponse(true, 200, "", counts));
        }
        [HttpGet("GetCategoryProductsCount")]
        public async Task<IActionResult> GetCategoryProductsCount()
        {
            var categories = await _repository.GetCategoryProductsCountAsync();
            return Ok(ApiResponseHelper.CreateResponse(true, 200, "", categories));
        }
        [HttpGet("GetLowStockProducts")]
        public async Task<IActionResult> GetLowStockProducts()
        {
            var categories = await _repository.GetLowStockProductsAsync();
            return Ok(ApiResponseHelper.CreateResponse(true, 200, "", categories));
        }
        [HttpGet("GetRecentActivities")]
        public async Task<IActionResult> GetRecentActivities()
        {
            var categories = await _repository.GetRecentActivitiesLogAsync();
            return Ok(ApiResponseHelper.CreateResponse(true, 200, "", categories));
        }
    }
}
