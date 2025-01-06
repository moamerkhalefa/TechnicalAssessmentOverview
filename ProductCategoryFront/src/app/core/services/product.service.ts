import { Injectable } from '@angular/core';
import { BaseService } from './base.service';
import { environment } from '../../../environments/environment';

@Injectable({
    providedIn: 'root',
})
export class ProductService extends BaseService {
    private baseUrl = `${environment.baseUrl}/Product`;

    // Create product
    createProduct(product: any) {
        return this.post<null>(`${this.baseUrl}/CreateProduct`, product);
    }

    // Get all categories
    getAllProducts() {
        return this.get<any[]>(`${this.baseUrl}/GetAllProducts`);
    }

    // Get product by ID
    getProductById(id: string) {
        return this.get<any>(`${this.baseUrl}/GetProduct/${id}`);
    }

    // Update product
    updateProduct(product: any) {
        return this.put<null>(`${this.baseUrl}/UpdateProduct`, product);
    }

    // Delete product
    deleteProduct(id: string) {
        return this.delete<null>(`${this.baseUrl}/DeleteProduct/${id}`);
    }

    // Get log by ID
    getProductLogById(id: string) {
        return this.get<any>(`${this.baseUrl}/GetProductLog/${id}`);
    }
}
