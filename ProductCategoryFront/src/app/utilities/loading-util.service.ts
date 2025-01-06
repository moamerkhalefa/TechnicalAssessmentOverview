import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
    providedIn: 'root'
})
export class LoadingUtilService {
    private loadingSubject = new BehaviorSubject<boolean>(false);

    get isLoading$() {
        return this.loadingSubject.asObservable();
    }

    show() {
        setTimeout(() => {
            this.loadingSubject.next(true);
        });
    }

    hide() {
        setTimeout(() => {
            this.loadingSubject.next(false);
        }, 1500);
    }
}
