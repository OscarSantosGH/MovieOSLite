//
//  VideoPlayerVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/21/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import WebKit

class VideoPlayerVC: UIViewController {
    
    var webView = WKWebView(frame: .zero)
    var trailerLink:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure(){
        webView.translatesAutoresizingMaskIntoConstraints = false
        let urlString = "https://www.youtube-nocookie.com/embed/" + trailerLink
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

}

extension VideoPlayerVC: WKUIDelegate{
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
}
