//
//  AuthBrowser.swift
//  Plugin
//


import Foundation
import SafariServices
import AuthenticationServices

@objc public class AuthBrowserEvent: NSObject {
    var url: String?;
    var success: Bool;
    var error: String?;
    
    init(success: Bool, url: String?, error: String?) {
        self.success = success;
        self.url = url;
        self.error = error;
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        dict["success"] = success
        
        if let url = url {
            dict["url"] = url
        }
        
        if let error = error {
            dict["error"] = error
        }
        
        return dict
    }
}

@objc public class AuthBrowser: NSObject {
    private var session: ASWebAuthenticationSession?
    public typealias BrowserEventCallback = (AuthBrowserEvent) -> Void

    @objc public var browserEventDidOccur: BrowserEventCallback?

    @objc public func start(for authURL: URL, scheme callbackScheme: String, plugin: CAPAuthBrowserPlugin) -> Bool {
        if let scheme = authURL.scheme?.lowercased(), ["http", "https"].contains(scheme) {
            session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: callbackScheme)
            { callbackURL, error in
                if ((error) != nil) {
                    let result = AuthBrowserEvent(success: false, url: nil, error: String(describing: error))
                    self.browserEventDidOccur?(result)
                } else {
                    guard let callbackURL = callbackURL else {
                        let result = AuthBrowserEvent(success: false, url: nil, error: "callbackURL is nil")
                        self.browserEventDidOccur?(result)
                        return;
                    }
                    
                    // Verify the URL scheme and remove it
                    if callbackURL.scheme == callbackScheme {
                        if let newURL = URL(string: callbackURL.absoluteString.replacingOccurrences(of: "\(callbackScheme)://", with: "")) {
                            let result = AuthBrowserEvent(success: true, url: newURL.absoluteString, error: nil)
                            self.browserEventDidOccur?(result)
                            return;
                        } else {
                            let result = AuthBrowserEvent(success: false, url: nil, error: "Error: Failed to create new URL without scheme")
                            self.browserEventDidOccur?(result)
                            return;
                        }
                    } else {
                        let result = AuthBrowserEvent(success: false, url: nil, error: "URL Scheme is not \(callbackScheme)")
                        self.browserEventDidOccur?(result)
                        return;
                    }
                }
            }
            session?.presentationContextProvider = plugin
            session?.start()
            return true;
        }
        return false;
    }

    @objc public func abort() {
        session?.cancel()
        session = nil
    }
}
