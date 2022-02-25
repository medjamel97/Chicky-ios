//
//  UserAgreementsView.swift
//  Chicky
//
//  Created by iMac on 25/2/2022.
//

import UIKit
import WebKit

class UserAgreementsView: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!;override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: HOST_URL + "templates/user-agreements")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
