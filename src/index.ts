import { registerPlugin } from '@capacitor/core';

import type { AuthBrowserPlugin } from './definitions';

const AuthBrowser = registerPlugin<AuthBrowserPlugin>('AuthBrowser', {
  web: () => import('./web').then(m => new m.AuthBrowserWeb()),
});

export * from './definitions';
export { AuthBrowser };
