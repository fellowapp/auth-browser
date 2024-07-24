# @fellow/auth-browser

The Auth Browser API provides the ability to open an in-app browser and subscribe to browser events.

On iOS, this uses `ASWebAuthenticationSession` and is compliant with leading OAuth service in-app-browser requirements.

on Android please use `@capacitor/browser` plugin.

## Install

```bash
npm install @fellow/auth-browser
npx cap sync
```

## Example

```typescript
import { AuthBrowser } from '@fellow/auth-browser';

const LoginWithN = async (n: string) => {
    const result = await AuthBrowser.start({
		url: n,
		scheme: "myapp",
	});
    
	alert(JSON.stringify(result));
	if (result.success) {
		// Handle success, result.url should be defined
	} else {
        // Handle result.error
    }
};
```

## API

<docgen-index>

* [`start(...)`](#start)
* [`abort()`](#abort)
* [Interfaces](#interfaces)
* [Type Aliases](#type-aliases)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### start(...)

```typescript
start(options: OpenOptions) => Promise<SuccessOrFailureResult>
```

iOS only: Open a page with the specified options.

Error on other platforms.

| Param         | Type                                                |
| ------------- | --------------------------------------------------- |
| **`options`** | <code><a href="#openoptions">OpenOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#successorfailureresult">SuccessOrFailureResult</a>&gt;</code>

**Since:** 1.0.0

--------------------


### abort()

```typescript
abort() => Promise<void>
```

iOS only: Close an open browser window.

Error on other platforms.

**Since:** 1.0.0

--------------------


### Interfaces


#### OpenOptions

Represents the options passed to `open`.

| Prop         | Type                | Description                                                                                                                                                | Since |
| ------------ | ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| **`url`**    | <code>string</code> | The URL to which the browser is opened.                                                                                                                    | 1.0.0 |
| **`scheme`** | <code>string</code> | The Scheme that the browser should listen to for to redirect back to the app. For example if you want to use the scheme `myapp://` you would pass `myapp`. |       |


### Type Aliases


#### SuccessOrFailureResult

<code><a href="#successresult">SuccessResult</a> | <a href="#failureresult">FailureResult</a></code>


#### SuccessResult

<code>{ success: true; url: string; }</code>


#### FailureResult

<code>{ success: false; error: string; }</code>

</docgen-api>
