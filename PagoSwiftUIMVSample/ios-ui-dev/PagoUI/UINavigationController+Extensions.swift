//
//  UINavigationController+Extensions.swift
//  PagoUISDK
//
//  Created by Bogdan on 11.07.2023.
//

import UIKit

public extension UINavigationController {
    
    var insertionIndex: Int {
        return max(self.viewControllers.count - 1, 0)
    }
    
    func insertControllers(_ controllers: [BaseViewController]) {
        
        self.viewControllers.insert(contentsOf: controllers, at: insertionIndex)
        //NOTE: This is required to hide Back title from back button
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.Pago.blackBodyText.color, NSAttributedString.Key.font: UIFont.Pago.semiBold17.font], for: .normal)
        controllers.forEach { $0.navigationItem.backBarButtonItem = item }
    }
}
