﻿using ProductsCategoriesMangSystem.Models;

public interface ICategoryRepository
{
    Task<IEnumerable<Category>> GetAllAsync();
    Task<Category?> GetByIdAsync(Guid id);
    Task AddAsync(Category category);
    Task UpdateAsync(Category category);
    Task DeleteAsync(Guid id);
    Task<IEnumerable<AuditLog>> GetLogAsync(Guid id);
}