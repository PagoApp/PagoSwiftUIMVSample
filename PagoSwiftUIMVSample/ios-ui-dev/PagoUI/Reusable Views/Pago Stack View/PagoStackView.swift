//
//  PagoStackView.swift
//  Pago
//
//  Created by Gabi Chiosa on 02/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

open class PagoStackView: UIStackView {

    public func insertVerticalSpace(_ height: CGFloat, color: UIColor? = nil, atIndex: Int) -> BaseView {
        
        let space = BaseView()
        if let colorT = color {
            space.backgroundColor = colorT
        }
        space.translatesAutoresizingMaskIntoConstraints = false
        space.heightAnchor.constraint(equalToConstant: height).isActive = true
        insertArrangedSubview(space, at: atIndex)
        space.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        space.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        return space
    }
    
    public func addVerticalSpace(_ height: CGFloat, color: UIColor? = nil) {
        
        let space = UIView()
        if let colorT = color {
            space.backgroundColor = colorT
        }
        space.translatesAutoresizingMaskIntoConstraints = false
        space.heightAnchor.constraint(equalToConstant: height).isActive = true
        addArrangedSubview(space)
        space.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        space.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    public func addHorizontalSpace(_ width: CGFloat) {
        let space = UIView()
        space.translatesAutoresizingMaskIntoConstraints = false
        space.widthAnchor.constraint(equalToConstant: width).isActive = true
        addArrangedSubview(space)
        space.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        space.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    public func addSeparator(_ width: CGFloat = 1, _ color: UIColor.Pago = .dividers) {
        let separator = UIView()
        separator.backgroundColor = color.color
        separator.translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .horizontal:
            separator.widthAnchor.constraint(equalToConstant: width).isActive = true
        case .vertical:
            separator.heightAnchor.constraint(equalToConstant: width).isActive = true
        @unknown default:
            break
        }
        addArrangedSubview(separator)
    }
    
    
}
