import Foundation
import AuthenticationServices
import Capacitor

@objc(CAPAuthBrowserPlugin)
public class CAPAuthBrowserPlugin: CAPPlugin, ASWebAuthenticationPresentationContextProviding {
    private let implementation = AuthBrowser()
    
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        var view: ASPresentationAnchor?
        
        DispatchQueue.main.sync {
            view = self.bridge?.webView?.window
        }
        
        return view ?? ASPresentationAnchor()
    }

    @objc func start(_ call: CAPPluginCall) {
        // validate the URL
        guard let urlString = call.getString("url"), let url = URL(string: urlString) else {
            let result = AuthBrowserEvent(success: false, url: nil, error: "Must provide a valid URL to open")
            call.resolve(result.toDictionary())
            return
        }
        // scheme
        guard let scheme = call.getString("scheme") else {
            let result = AuthBrowserEvent(success: false, url: nil, error: "Must provide a valid SCHEME to open")
            call.resolve(result.toDictionary())
            return
        }
        // prepare for display
        guard implementation.start(for: url, scheme: scheme, plugin: self) else {
            let result = AuthBrowserEvent(success: false, url: nil, error: "Unable to display URL")
            call.resolve(result.toDictionary())
            return
        }
        implementation.browserEventDidOccur = { event in
            call.resolve(event.toDictionary())
        }
    }

    @objc func abort(_ call: CAPPluginCall) {
        implementation.abort()
    }

    private func presentationStyle(for style: String?) -> UIModalPresentationStyle {
        if let style = style, style == "popover" {
            return .popover
        }
        return .fullScreen
    }
}
