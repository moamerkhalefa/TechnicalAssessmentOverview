
import { DatePipe, isPlatformBrowser } from '@angular/common';
import { ChangeDetectorRef, Component, effect, inject, OnInit, PLATFORM_ID } from '@angular/core';
import { ChartModule } from 'primeng/chart';
import { CardModule } from 'primeng/card';
import { DashboardService } from '../core/services/dashboard.service';
import { TableModule } from 'primeng/table';
import { BadgeModule } from 'primeng/badge';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  standalone: true,
  imports: [ChartModule, CardModule, BadgeModule, TableModule],
  providers: [DatePipe]
})
export class DashboardComponent implements OnInit {
  counts: any = {};
  categories: Category[] = [];
  products: any = [];
  activites: any = [];
  basicData: any;
  basicOptions: any;
  statusOptions = [
    { name: 'Active', id: 1 },
    { name: 'Inactive', id: 2 },
    { name: 'Discontinued', id: 3 },
  ];
  platformId = inject(PLATFORM_ID);
  constructor(private cd: ChangeDetectorRef, private datePipe: DatePipe, private dashboardService: DashboardService) { }

  ngOnInit() {
    this.getCounts();
    this.getCategoryProductsCount();
    this.getLowStockProducts();
    this.getRecentActivities();
  }

  getCounts(): void {
    this.dashboardService.getCounts().subscribe({
      next: (data) => {
        this.counts = data;
      },
      error: () => {
      },
      complete: () => {

      }
    });
  }

  getCategoryProductsCount(): void {
    this.dashboardService.getCategoryProductsCount().subscribe({
      next: (data) => {
        this.categories = data;
        this.initChart();
      },
      error: () => {
      },
      complete: () => {

      }
    });
  }

  getRecentActivities(): void {
    this.dashboardService.getRecentActivities().subscribe({
      next: (data) => {
        this.activites = data;
      },
      error: () => {
      },
      complete: () => {

      }
    });
  }

  getLowStockProducts(): void {
    this.dashboardService.getLowStockProducts().subscribe({
      next: (data) => {
        this.products = data;
      },
      error: () => {
      },
      complete: () => {

      }
    });
  }

  getStatucSeverity(status: number) {
    if (status === 1) return 'success';
    if (status === 3) return 'warn';
    else return 'danger';
  }

  logActionSeverity(action: string) {
    if (action === 'Create') return 'success';
    else if (action === 'Update') return 'info';
    else if (action === 'Delete') return 'danger';
    else return 'danger';
  }

  getStatusLabel(value: number): string {
    const option = this.statusOptions.find(option => option.id === value);
    return option ? option.name : 'Inactive';
  }

  formatDate(dateString: string): string {
    const date = new Date(dateString);
    return this.datePipe.transform(date, 'dd/MM/yyyy hh:mm a') || '';
  }

  initChart() {
    if (isPlatformBrowser(this.platformId)) {
      const documentStyle = getComputedStyle(document.documentElement);
      const textColor = documentStyle.getPropertyValue('--p-text-color');
      const textColorSecondary = documentStyle.getPropertyValue('--p-text-muted-color');
      const surfaceBorder = documentStyle.getPropertyValue('--p-content-border-color');
      const labels = this.categories.map(item => item.name);
      const data = this.categories.map(category => category.productsCount);
      const backgroundColors = this.categories.map(() =>
        `rgba(${Math.floor(Math.random() * 256)}, ${Math.floor(Math.random() * 256)}, ${Math.floor(Math.random() * 256)}, 0.2)`
      );

      const borderColors = this.categories.map(() =>
        `rgb(${Math.floor(Math.random() * 256)}, ${Math.floor(Math.random() * 256)}, ${Math.floor(Math.random() * 256)})`
      );
      this.basicData = {
        labels: labels,
        datasets: [
          {
            label: 'Products Count',
            data: data,
            backgroundColor: backgroundColors,
            borderColor: borderColors,
            borderWidth: 1,
          },
        ],
      };
      this.basicOptions = {
        plugins: {
          legend: {
            labels: {
              color: textColor,
            },
          },
        },
        scales: {
          x: {
            ticks: {
              color: textColorSecondary,
            },
            grid: {
              color: surfaceBorder,
            },
          },
          y: {
            beginAtZero: true,
            ticks: {
              color: textColorSecondary,
            },
            grid: {
              color: surfaceBorder,
            },
          },
        },
      };
      this.cd.markForCheck();
    }
  }
}
interface Category {
  name: string;
  productsCount: number;
  status: number;
}