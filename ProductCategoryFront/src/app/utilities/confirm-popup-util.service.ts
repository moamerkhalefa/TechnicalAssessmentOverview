import { Injectable } from '@angular/core';
import { ConfirmationService } from 'primeng/api';

@Injectable({
    providedIn: 'root',
})
export class ConfirmPopupUtilService {
    constructor(private confirmationService: ConfirmationService) { }
    showConfirm(useInLine: boolean, header: string, message: string, icon: string = 'pi pi-info-circle', acceptLabel: string = 'Delete', event: Event, acceptCallback: () => void, rejectCallback?: () => void): void {
        const options = {
            target: event.target as EventTarget,
            header: header,
            message: message,
            icon: icon,
            key: 'dialog',
            rejectButtonProps: {
                label: 'Cancel',
                severity: 'secondary',
                outlined: true
            },
            acceptButtonProps: {
                label: acceptLabel,
                severity: 'danger'
            },
            accept: acceptCallback,
            reject: rejectCallback
        }
        if (useInLine) {
            options.key = 'useInLine';
        }
        this.confirmationService.confirm(options);
    }
}
