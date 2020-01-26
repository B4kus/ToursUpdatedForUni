//
//  ViewConfigurable.swift
//  Tours
//
//  Created by Szymon Szysz on 20/10/2019.
//  Copyright © 2019 Szymon Szysz. All rights reserved.
//

import UIKit

typealias ViewConfigurable = ViewContainable & ViewLoadable

protocol ViewContainable {
    associatedtype ContentViewType: UIView
    var contentView: ContentViewType { get }
}

extension ViewContainable where Self: UIViewController {
    var contentView: ContentViewType {
        guard let view = view as? ContentViewType else { return ContentViewType() }
        return view
    }
}

protocol ViewLoadable {
    associatedtype ContentViewType: UIView
    func loadContentView()
}

extension ViewLoadable where Self: UIViewController {
    func loadContentView() {
        view = ContentViewType()
    }
}

extension UIViewController {
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
