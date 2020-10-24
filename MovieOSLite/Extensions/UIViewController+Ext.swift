//
//  UIViewController+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 4/12/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {

    // this is a custom UIAlertController for convenience and readability
    func presentMOAlert(title:String, message: String){
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertViewController.dismiss(animated: true)
            }
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true)
        }
    }
    
    func showLoadingState(){
        let containerView = UIView()
        let activityView = UIActivityIndicatorView(style: .large)
        let blurView = UIVisualEffectView()
        let blurFX = UIBlurEffect(style: .systemMaterial)
        blurView.effect = blurFX
        blurView.alpha = 0.8
        containerView.tag = 100
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        activityView.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        view.bringSubviewToFront(containerView)
        containerView.addSubviews(blurView, activityView)
        
        containerView.pinToEdges(of: view)
        blurView.pinToEdges(of: containerView)
        NSLayoutConstraint.activate([
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityView.startAnimating()
    }
    
    func hideLoadingState(){
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else {return}
            for loadingView in self.view.subviews{
                if loadingView.tag == 100{
                    loadingView.removeFromSuperview()
                }
            }
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemPurple
        present(safariVC, animated: true)
    }
    
}
