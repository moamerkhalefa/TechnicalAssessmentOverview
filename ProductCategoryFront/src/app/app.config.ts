import { ApplicationConfig, provideZoneChangeDetection } from '@angular/core';
import { provideRouter } from '@angular/router';
import { routes } from './app.routes';
import { provideHttpClient } from '@angular/common/http';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { MessageService, ConfirmationService } from 'primeng/api';
import { providePrimeNG } from 'primeng/config';
import Aura from '@primeng/themes/aura';
// import Material from '@primeng/themes/Material';
// import Lara from '@primeng/themes/Lara';
// import Nora from '@primeng/themes/Nora';

export const appConfig: ApplicationConfig = {
  providers: [provideZoneChangeDetection({ eventCoalescing: true }), provideRouter(routes), provideHttpClient(), MessageService, ConfirmationService, provideAnimationsAsync(),
  providePrimeNG({
    ripple: true,
    theme: {
      preset: Aura,
      options: {
        // prefix: 'p',
        // darkModeSelector: 'system',
        // cssLayer: false
      }
    }
  })]
};
