//
//  VideoPlayerVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/21/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import WebKit

class VideoPlayerVC: UIViewController, WKUIDelegate{
    
    var webView = WKWebView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.pinToEdges(of: view)
        webView.uiDelegate = self
    }
    
    func showTrailerWithKey(key: String){
        let urlString = "https://www.youtube-nocookie.com/embed/" + key
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

}
