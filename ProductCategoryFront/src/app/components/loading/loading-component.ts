import { Component } from '@angular/core';
import { ProgressSpinner } from 'primeng/progressspinner';
import { LoadingUtilService } from '../../utilities/loading-util.service';
import { Observable } from 'rxjs';
import { CommonModule } from '@angular/common';

@Component({
    selector: 'app-loader',
    templateUrl: './loading-component.html',
    styleUrls: ['./loading-component.css'],
    standalone: true,
    imports: [ProgressSpinner, CommonModule]
})
export class loadingComponent {
    isLoading: Observable<boolean>;
    constructor(private loadingService: LoadingUtilService) {
        this.isLoading = this.loadingService.isLoading$;
    }
}