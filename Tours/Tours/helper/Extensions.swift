//
//  Extensions.swift
//  Tours
//
//  Created by Szymon Szysz on 24.06.2018.
//  Copyright © 2018 Szymon Szysz. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    public func presentTransparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.view.backgroundColor = .white
    }
    
    public func hideTransparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.view.backgroundColor = .white
    }
}


