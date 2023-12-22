//
//  BaseTextField.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import Foundation
import UIKit

protocol BaseTextFieldDelegate: AnyObject {
    func deleteBackward()
}

class BaseTextField: UITextField {
    
    weak var baseDelegate: BaseTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        baseDelegate?.deleteBackward()
    }
    
    override func delete(_ sender: Any?) {
        text = ""
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(cut(_:)) {
            return false
        }
        return true
    }
}
