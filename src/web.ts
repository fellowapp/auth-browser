import { WebPlugin } from '@capacitor/core';

import type { AuthBrowserPlugin, OpenOptions, SuccessOrFailureResult } from './definitions';

export class AuthBrowserWeb extends WebPlugin implements AuthBrowserPlugin {
  _lastWindow: Window | null;

  constructor() {
    super();
    this._lastWindow = null;
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  async start(_options: OpenOptions): Promise<SuccessOrFailureResult> {
    throw new Error("Method not implemented on web.");
  }

  async abort(): Promise<void> {
    throw new Error("Method not implemented on web.");
  }
}

const AuthBrowser = new AuthBrowserWeb();

export { AuthBrowser };
