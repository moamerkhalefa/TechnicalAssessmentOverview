import { Component, OnInit, ViewChild } from '@angular/core';
import { CategoryService } from '../core/services/category.service';
import { Category } from '../core/models/category-model';
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


@Component({
    standalone: true,
    selector: 'app-categories',
    templateUrl: './categories.component.html',
    styleUrls: ['./categories.component.css'],
    imports: [
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
export class CategoriesComponent implements OnInit {
    @ViewChild('categoriesTable') table!: Table;
    auditLogs: AuditLog[] = [];
    categories: Category[] = [];
    categoriesOptions: Category[] = [];
    category: Category = this.initializeCategory();
    showReqired = false;
    logDialog = false;
    logHeaderText = "";
    clonedCategory: { [s: string]: Category } = {};

    statusOptions = [
        { name: 'Active', id: 1 },
        { name: 'Inactive', id: 2 },
    ];

    constructor(private messageUtilService: MessageUtilService, private datePipe: DatePipe, private categoryService: CategoryService, private ConfirmPopup: ConfirmPopupUtilService) {

    }

    ngOnInit(): void {
        this.loadCategories();
    }

    onRowEditInit(category: Category) {
        this.clonedCategory[category.id as string] = { ...category };
        this.categoriesOptions = [];
        if (this.categories && this.categories.length > 0) {
            this.categoriesOptions = this.categories.filter(item => item.id !== category.id);
        }
    }

    onRowEditSave(category: Category) {
        this.showReqired = true;
        if (category.name && category.status) {
            const option = category.id
                ? this.categoryService.updateCategory(category)
                : this.categoryService.createCategory(category);
            option.subscribe({
                next: () => {
                    if (!category.id) {
                        delete this.clonedCategory[category.id as string];
                    }
                    this.loadCategories();
                    this.showReqired = false;
                },
                error: () => {
                    setTimeout(() => {
                        this.table.initRowEdit(category);
                    }, 0);
                },
                complete: () => {

                }
            });
        }
        else {
            this.messageUtilService.showMessage("error", "Required Data", "Please fill the required fields");
            setTimeout(() => {
                this.table.initRowEdit(category);
            }, 0);
        }
    }

    onRowEditCancel(category: Category, index: number) {
        if (!category.id) {
            this.categories.splice(index, 1);
        } else {
            this.categories[index] = this.clonedCategory[category.id as string];
            delete this.clonedCategory[category.id as string];
        }
    }

    loadCategories(): void {
        this.categoryService.getAllCategories().subscribe({
            next: (data) => {
                this.categories = data;
            },
            error: () => {
            },
            complete: () => {

            }
        });
    }

    addNewCategory(): void {
        this.showReqired = false;
        const hasInvalidId = this.categories.some(
            item => item.id === null || item.id === '' || item.id === undefined
        );
        if (!hasInvalidId) {
            this.categoriesOptions = this.categories.filter(item => item.id);
            const newCategory: Category = this.initializeCategory();
            this.categories = [newCategory, ...this.categories];
            setTimeout(() => {
                this.table.initRowEdit(newCategory);
            }, 0);
        }
    }

    openDialog(): void {
        this.logDialog = true;
    }

    closeDialog(): void {
        this.logDialog = false;
    }

    confirmDeleteCategory(id: string, event: Event): void {
        this.ConfirmPopup.showConfirm(true, 'Delete Category', 'Do you want to delete this record ?', 'pi pi-info-circle', 'Delete', event, () => { this.deleteCategory(id) });
    }

    deleteCategory(id: string): void {
        this.categoryService.deleteCategory(id).subscribe({
            next: () => {
                this.loadCategories();
            },
            error: () => {

            },
            complete: () => {

            }
        });
    }

    getCategoryLog(category: Category): void {
        this.categoryService.getCategoryLogById(category.id).subscribe({
            next: (data) => {
                this.auditLogs = data;
                this.logHeaderText = `Category ${category.name} Log Details`;
                this.openDialog();
            },
            error: () => {

            },
            complete: () => {

            }
        });
    }

    categoryStatucSeverity(category: Category) {
        if (category.status === 1) return 'success';
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

    getParentName(parentId: string): string {
        const option = this.categories.find(option => option.id === parentId);
        return option ? option.name : '';
    }

    formatDate(dateString: string): string {
        const date = new Date(dateString);
        return this.datePipe.transform(date, 'dd/MM/yyyy hh:mm a') || '';
    }

    private initializeCategory(): Category {
        return {
            id: '',
            name: '',
            description: '',
            parentCategoryId: undefined,
            status: 0,
            createdDate: new Date(),
            updatedDate: undefined,
        };
    }
}
