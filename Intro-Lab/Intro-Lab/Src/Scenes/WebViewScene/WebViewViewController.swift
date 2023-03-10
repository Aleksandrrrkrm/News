

import UIKit
import WebKit

final class WebViewViewController: UIViewController, WKUIDelegate {
    
    internal var presenter: WebViewPresenter?

    var webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        guard let url = presenter?.url else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
    }
}


extension WebViewViewController: WebViewView {
}
