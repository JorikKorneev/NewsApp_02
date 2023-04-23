//
//  WebView.swift
//
//  Created by admin on 20.04.2023.
//

import UIKit
import WebKit

class WebView: UIViewController {
    var urlWeb = ""

    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
        loadRequest()
    }

    private func loadRequest() {
        guard let url = URL(string: urlWeb) else { return }
        let urlReqest = URLRequest(url: url)
        webView.load(urlReqest)
    }
}
