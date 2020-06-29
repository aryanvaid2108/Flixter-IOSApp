//
//  TrailerViewController.swift
//  Flixter
//
//  Created by Aryan Vaid on 5/25/20.
//  Copyright © 2020 Aryan Vaid. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
    var key = ""
   
    @IBOutlet weak var webView: WKWebView!
    
    override func loadView(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: "https://www.youtube.com/watch?v=\(key)" )
        let myRequest = URLRequest(url: url!)
        
        webView.load(myRequest)
  }
    
}
