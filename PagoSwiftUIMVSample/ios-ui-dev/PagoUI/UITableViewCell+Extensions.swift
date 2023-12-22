//
//  UITableViewCell+Extensions.swift
//  Pago
//
//  Created by Mihai Arosoaie on 16/01/17.
//  Copyright © 2017 timesafe. All rights reserved.
//

import Foundation
import UIKit

public extension UITableViewCell {
    
    class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}


public extension UICollectionViewCell {
    
    class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}
