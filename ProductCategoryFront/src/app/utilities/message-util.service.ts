import { Injectable } from '@angular/core';
import { MessageService } from 'primeng/api';

@Injectable({
    providedIn: 'root',
})
export class MessageUtilService {
    constructor(private messageService: MessageService) { }

    showMessage(severity: string, summary: string, detail: string): void {
        this.messageService.add({ severity, summary, detail });
    }
}
