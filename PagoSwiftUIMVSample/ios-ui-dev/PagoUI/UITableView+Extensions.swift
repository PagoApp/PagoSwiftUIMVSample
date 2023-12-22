//
//  UITableView+Extensions.swift
//  Pago
//
//  Created by Mihai Arosoaie on 27/01/17.
//  Copyright © 2017 timesafe. All rights reserved.
//

import Foundation
import UIKit

internal extension UITableView {
    
    func registerCellUsingNib<T>(_ type: T.Type) where T: UITableViewCell {
        self.register(type.nib, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerCellUsingClass<T>(_ type: T.Type) where T: UITableViewCell {
        self.register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeue<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeue<T>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: T.self.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeue<T>(_ type: T.Type) -> T where T: UITableViewHeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier) as! T
    }
    
    func dequeue<T>() -> T where T: UITableViewHeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: T.self.reuseIdentifier) as! T
    }
    
    func registerHeaderFooterViewUsingNib<T>(_ type: T.Type) where T: UITableViewHeaderFooterView {
        self.register(type.nib, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerHeaderFooterViewUsingClass<T>(_ type: T.Type) where T: UITableViewHeaderFooterView {
        self.register(type, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }
    
}
