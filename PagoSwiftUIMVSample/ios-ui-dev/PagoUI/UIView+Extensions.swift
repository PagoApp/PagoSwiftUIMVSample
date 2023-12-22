//
//  UIView+Extensions.swift
//  Pago
//
//  Created by Mihai Arosoaie on 27/02/2017.
//  Copyright © 2017 timesafe. All rights reserved.
//

import UIKit

extension PagoView {
    func firstSubViewWithType<T>(type: T.Type) -> T? where T: PagoView {
        if let view = subviews.first(where: {$0 is T}) as? T {
            return view
        } else {
            for subview in subviews {
                if let view = (subview as? T)?.firstSubViewWithType(type: type) {
                    return view
                }
            }
        }
        return nil
    }
    
    func addLinearGradient(colors: [UIColor], gradientLocations: [CGPoint]) {
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = gradientLocations.first!
        gradient.endPoint = gradientLocations.last!
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: CGColor? {
        get {
            return layer.borderColor
        }
        set {
            layer.borderColor = newValue
        }
    }
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    public func removeAllPagoSubviews() {
        for v in subviews {
            v.removeFromSuperview()
        }
    }
}


internal extension UIView {
    class func fromNib() -> Self {
        return loadFromNib()
    }
    
    class func loadFromNib<T>() -> T where T: UIView {
        let bundle = Bundle(identifier: "com.pago.PagoUI")
        let nib = UINib(nibName: String(describing: T.self), bundle: bundle).instantiate(withOwner: nil, options: nil).first as! T
        return nib
    }
}

extension PagoStackView {
    
    public func removeAllPagoSubviews() {
        
        for v in subviews {
            v.removeFromSuperview()
        }
    }
}
