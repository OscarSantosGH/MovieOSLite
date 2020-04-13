//
//  UIViewController+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 4/12/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

extension UIViewController {

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
