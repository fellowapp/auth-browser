type SuccessResult = {
  success: true;
  url: string;
};

type FailureResult = {
  success: false;
  error: string;
};

export type SuccessOrFailureResult = SuccessResult | FailureResult;

export interface AuthBrowserPlugin {
  /**
   * iOS only: Open a page with the specified options.
   *
   * Error on other platforms.
   *
   * @since 1.0.0
   */
  start(options: OpenOptions): Promise<SuccessOrFailureResult>;

  /**
   * iOS only: Close an open browser window.
   *
   * Error on other platforms.
   *
   * @since 1.0.0
   */
  abort(): Promise<void>;
}

/**
 * Represents the options passed to `open`.
 *
 * @since 1.0.0
 */
export interface OpenOptions {
  /**
   * The URL to which the browser is opened.
   *
   * @since 1.0.0
   */
  url: string;

  /**
   * The Scheme that the browser should listen to for to redirect back to the app.
   * For example if you want to use the scheme `myapp://` you would pass `myapp`.
   */
  scheme?: string;
}
