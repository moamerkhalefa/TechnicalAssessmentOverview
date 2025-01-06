export interface Category {
    id: string;
    name: string;
    description?: string;
    parentCategoryId?: string;
    status: number;
    createdDate: Date;
    updatedDate?: Date;
}