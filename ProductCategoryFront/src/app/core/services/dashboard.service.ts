import { Injectable } from '@angular/core';
import { BaseService } from './base.service';
import { environment } from '../../../environments/environment';

@Injectable({
    providedIn: 'root',
})
export class DashboardService extends BaseService {
    private baseUrl = `${environment.baseUrl}/Dashboard`;
    getCounts() {
        return this.get<any[]>(`${this.baseUrl}/GetCounts`);
    }
    getCategoryProductsCount() {
        return this.get<any[]>(`${this.baseUrl}/GetCategoryProductsCount`);
    }
    getLowStockProducts() {
        return this.get<any[]>(`${this.baseUrl}/GetLowStockProducts`);
    }
    getRecentActivities() {
        return this.get<any[]>(`${this.baseUrl}/GetRecentActivities`);
    }
}
