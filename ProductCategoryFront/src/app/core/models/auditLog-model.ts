export interface AuditLog {
    id: string;
    timestamp: Date;
    action: string;
    entityName: string;
    entityId: string;
    oldValues?: string;
    newValues?: string;
    userId?: string;
    ipAddress?: string;
}
