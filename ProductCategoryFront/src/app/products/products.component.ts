import { Component, OnInit, ViewChild } from '@angular/core';
import { ProductService } from '../core/services/product.service';
import { Product } from '../core/models/product-model';
import { CommonModule, DatePipe } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';
import { FormsModule } from '@angular/forms';
import { Table, TableModule } from 'primeng/table';
import { InputTextModule } from 'primeng/inputtext';
import { ButtonModule } from 'primeng/button';
import { SelectModule } from 'primeng/select';
import { DialogModule } from 'primeng/dialog';
import { BadgeModule } from 'primeng/badge';
import { PanelModule } from 'primeng/panel';
import { ConfirmPopupUtilService } from '../utilities/confirm-popup-util.service';
import { AuditLog } from '../core/models/auditLog-model';
import { TagModule } from 'primeng/tag';
import { SplitButtonModule } from 'primeng/splitbutton';
import { MessageUtilService } from '../utilities/message-util.service';
import { CategoryService } from '../core/services/category.service';
import { AvatarModule } from 'primeng/avatar';


@Component({
  standalone: true,
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.css'],
  imports: [
    AvatarModule,
    SplitButtonModule,
    TagModule,
    PanelModule,
    BadgeModule,
    FormsModule,
    CommonModule,
    ReactiveFormsModule,
    TableModule,
    InputTextModule,
    ButtonModule,
    SelectModule,
    DialogModule,
  ],
  providers: [DatePipe]
})
export class ProductsComponent implements OnInit {
  @ViewChild('productsTable') table!: Table;
  auditLogs: AuditLog[] = [];
  products: Product[] = [];
  categoriesOptions: Product[] = [];
  product: Product = this.initializeProduct();
  showReqired = false;
  logDialog = false;
  logHeaderText = "";
  clonedProduct: { [s: string]: Product } = {};

  statusOptions = [
    { name: 'Active', id: 1 },
    { name: 'Inactive', id: 2 },
    { name: 'Discontinued', id: 3 },
  ];

  constructor(private messageUtilService: MessageUtilService, private datePipe: DatePipe, private productService: ProductService, private categoryService: CategoryService, private ConfirmPopup: ConfirmPopupUtilService) {

  }

  ngOnInit(): void {
    this.getCategoriesList();
  }

  getCategoriesList(): void {
    this.categoryService.getAllCategories().subscribe({
      next: (data) => {
        this.categoriesOptions = data;
      },
      error: () => {
      },
      complete: () => {
        this.loadProducts();
      }
    });
  }

  onRowEditInit(product: Product) {
    this.clonedProduct[product.id as string] = { ...product };
  }

  onRowEditSave(product: Product) {
    if (!product.imageUrl) {
      product.imageUrl = '/package2.png';
    }
    this.showReqired = true;
    if (product.name && product.description && product.price && product.status && product.stockQuantity && product.categoryId) {
      const option = product.id
        ? this.productService.updateProduct(product)
        : this.productService.createProduct(product);
      option.subscribe({
        next: () => {
          if (!product.id) {
            delete this.clonedProduct[product.id as string];
          }
          this.loadProducts();
          this.showReqired = false;
        },
        error: () => {
          setTimeout(() => {
            this.table.initRowEdit(product);
          }, 0);
        },
        complete: () => {

        }
      });
    }
    else {
      this.messageUtilService.showMessage("error", "Required Data", "Please fill the required fields");
      setTimeout(() => {
        this.table.initRowEdit(product);
      }, 0);
    }
  }

  onRowEditCancel(product: Product, index: number) {
    if (!product.id) {
      this.products.splice(index, 1);
    } else {
      this.products[index] = this.clonedProduct[product.id as string];
      delete this.clonedProduct[product.id as string];
    }
  }

  loadProducts(): void {
    this.productService.getAllProducts().subscribe({
      next: (data) => {
        this.products = data;
      },
      error: () => {
      },
      complete: () => {

      }
    });
  }

  addNewProduct(): void {
    this.showReqired = false;
    const hasInvalidId = this.products.some(
      item => item.id === null || item.id === '' || item.id === undefined
    );
    if (!hasInvalidId) {
      const newProduct: Product = this.initializeProduct();
      this.products = [newProduct, ...this.products];
      setTimeout(() => {
        this.table.initRowEdit(newProduct);
      }, 0);
    }
  }

  openDialog(): void {
    this.logDialog = true;
  }

  closeDialog(): void {
    this.logDialog = false;
  }

  confirmDeleteProduct(id: string, event: Event): void {
    this.ConfirmPopup.showConfirm(true, 'Delete Product', 'Do you want to delete this record ?', 'pi pi-info-circle', 'Delete', event, () => { this.deleteProduct(id) });
  }

  deleteProduct(id: string): void {
    this.productService.deleteProduct(id).subscribe({
      next: () => {
        this.loadProducts();
      },
      error: () => {

      },
      complete: () => {

      }
    });
  }

  getProductLog(product: Product): void {
    this.productService.getProductLogById(product.id).subscribe({
      next: (data) => {
        this.auditLogs = data;
        this.logHeaderText = `Product ${product.name} Log Details`;
        this.openDialog();
      },
      error: () => {

      },
      complete: () => {

      }
    });
  }

  productStatucSeverity(product: Product) {
    if (product.status === 1) return 'success';
    if (product.status === 3) return 'warn';
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

  getCategoryName(categoryId: string): string {
    const option = this.categoriesOptions.find(option => option.id === categoryId);
    return option ? option.name : '';
  }

  formatDate(dateString: string): string {
    const date = new Date(dateString);
    return this.datePipe.transform(date, 'dd/MM/yyyy hh:mm a') || '';
  }

  private initializeProduct(): Product {
    return {
      id: '',
      name: '',
      description: '',
      price: 0,
      categoryId: '',
      status: 0,
      stockQuantity: 0,
      imageUrl: '/package2.png',
      createdDate: new Date(),
      updatedDate: undefined,
    };
  }
}