//
//  UINavigationBar+Extensions.swift
//  CommonExtensions
//
//  Created by Gabi Chiosa on 17/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    public func makeItFlatWhite() {
        
        isTranslucent = false
        tintColor = .black
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.shadowColor = .clear
            navBarAppearance.backgroundColor = .white
            navBarAppearance.backgroundImage = UIImage()
            navBarAppearance.shadowImage = UIImage()
            scrollEdgeAppearance = navBarAppearance
            standardAppearance = navBarAppearance
        } else {
            backgroundColor = .white
            setBackgroundImage(UIImage(), for: .default)
            shadowImage = UIImage()
        }
    }
    
    public func update(bgColor: UIColor, tintColor color: UIColor) {
        
        isTranslucent = true
        tintColor = color
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.shadowColor = .clear
            navBarAppearance.backgroundColor = bgColor
            navBarAppearance.backgroundImage = UIImage()
            navBarAppearance.shadowImage = UIImage()
            navBarAppearance.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : color ]
            scrollEdgeAppearance = navBarAppearance
            standardAppearance = navBarAppearance
        } else {
            backgroundColor = bgColor
            setBackgroundImage(UIImage(), for: .default)
            shadowImage = UIImage()
            titleTextAttributes = [ NSAttributedString.Key.foregroundColor : color ]
        }
    }
    
    public func makeItTransparent() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.shadowColor = .clear
            navBarAppearance.backgroundImage = UIImage()
            navBarAppearance.shadowImage = UIImage()
            scrollEdgeAppearance = navBarAppearance
            standardAppearance = navBarAppearance
        } else {
            setBackgroundImage(UIImage(), for: .default)
            shadowImage = UIImage()
        }
        isTranslucent = true
    }
}
