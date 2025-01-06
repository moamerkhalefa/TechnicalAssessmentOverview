export interface Product {
    id: string;
    name: string;
    description: string;
    price: number;
    categoryId: string;
    status: number;
    stockQuantity: number;
    imageUrl?: string;
    createdDate: Date;
    updatedDate?: Date;
}