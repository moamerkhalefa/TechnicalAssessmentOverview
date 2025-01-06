import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { ApiResponse } from '../models/api-response.model';
import { MessageUtilService } from '../../utilities/message-util.service';
import { LoadingUtilService } from '../../utilities/loading-util.service';

@Injectable({
    providedIn: 'root',
})
export class BaseService {
    constructor(protected http: HttpClient, private messageUtilService: MessageUtilService, private loadingService: LoadingUtilService) { }

    // Handle HTTP GET requests
    protected get<T>(url: string): Observable<T> {
        this.loadingService.show();
        return this.http.get<ApiResponse<T>>(url).pipe(
            map((response) => this.processResponse(response)),
            catchError((error) => this.handleError(error))
        );
    }

    // Handle HTTP POST requests
    protected post<T>(url: string, body: any): Observable<T> {
        this.loadingService.show();
        return this.http.post<ApiResponse<T>>(url, body).pipe(
            map((response) => this.processResponse(response)),
            catchError((error) => this.handleError(error))
        );
    }

    // Handle HTTP PUT requests
    protected put<T>(url: string, body: any): Observable<T> {
        this.loadingService.show();
        return this.http.put<ApiResponse<T>>(url, body).pipe(
            map((response) => this.processResponse(response)),
            catchError((error) => this.handleError(error))
        );
    }

    // Handle HTTP DELETE requests
    protected delete<T>(url: string): Observable<T> {
        this.loadingService.show();
        return this.http.delete<ApiResponse<T>>(url).pipe(
            map((response) => this.processResponse(response)),
            catchError((error) => this.handleError(error))
        );
    }

    private processResponse<T>(response: ApiResponse<T>): T | never {
        if (response.isSuccess) {
            if (response.message && response.message.length > 0) {
                this.messageUtilService.showMessage("success", "Sucess", response.message);
            }
            this.loadingService.hide();
            return response.data;
        } else {
            this.messageUtilService.showMessage("error", "Error Occurred", response.message || 'Operation failed');
            this.loadingService.hide();
            throw new Error(response.message || 'Operation failed');
        }
    }

    private handleError(error: HttpErrorResponse): Observable<never> {
        let errorMessage = 'An unknown error occurred!';
        if (error.error instanceof ErrorEvent) {
            errorMessage = `Client-side error: ${error.error.message}`;
        } else {
            switch (error.status) {
                case 400:
                    errorMessage = 'There was a problem with your request. Please check and try again.';
                    break;
                case 401:
                    errorMessage = 'You are not authorized to perform this action. Please log in and try again.';
                    break;
                case 403:
                    errorMessage = 'You do not have permission to access this resource.';
                    break;
                case 404:
                    errorMessage = 'The requested resource was not found.';
                    break;
                case 500:
                    errorMessage = 'An internal server error occurred. Please try again later.';
                    break;
                default:
                    errorMessage = 'Something went wrong. Please try again.';
                    break;
            }
        }
        console.error(errorMessage);
        this.messageUtilService.showMessage("error", "Error Occurred", errorMessage);
        this.loadingService.hide();
        return throwError(() => new Error(errorMessage));
    }
}
