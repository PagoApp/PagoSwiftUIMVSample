//
//  UITableViewHeaderFooterView.swift
//  Pago
//
//  Created by Mihai Arosoaie on 03/02/17.
//  Copyright © 2017 timesafe. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewHeaderFooterView {
    
    class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}
