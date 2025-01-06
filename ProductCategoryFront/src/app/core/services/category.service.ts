import { Injectable } from '@angular/core';
import { BaseService } from './base.service';
import { environment } from '../../../environments/environment';

@Injectable({
    providedIn: 'root',
})
export class CategoryService extends BaseService {
    private baseUrl = `${environment.baseUrl}/Category`;

    // Create category
    createCategory(category: any) {
        return this.post<null>(`${this.baseUrl}/CreateCategory`, category);
    }

    // Get all categories
    getAllCategories() {
        return this.get<any[]>(`${this.baseUrl}/GetAllCategories`);
    }

    // Get category by ID
    getCategoryById(id: string) {
        return this.get<any>(`${this.baseUrl}/GetCategory/${id}`);
    }

    // Update category
    updateCategory(category: any) {
        return this.put<null>(`${this.baseUrl}/UpdateCategory`, category);
    }

    // Delete category
    deleteCategory(id: string) {
        return this.delete<null>(`${this.baseUrl}/DeleteCategory/${id}`);
    }

    // Get log by ID
    getCategoryLogById(id: string) {
        return this.get<any>(`${this.baseUrl}/GetCategoryLog/${id}`);
    }
}
