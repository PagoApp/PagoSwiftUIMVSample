//
//  Extensions.swift
//  Pago
//
//  Created by Mihai Arosoaie on 12/04/16.
//  Copyright © 2016 timesafe. All rights reserved.
//
import UIKit

public class DeviceSizeHelper {
    
    public typealias ScreenSize = (width:Int, height:Int)
    
    public static let iPhone4Size = (width: 320, height: 480)
    public static let iPhone5Size = (width: 320, height: 568)
    public static let iPhone6Size = (width: 375, height: 667)
    public static let iPhone6PSize = (width: 414, height: 736)
    public static let iPhoneXSize = (width: 375, height: 812)

    static let kIphone5Width = 320
    
    public class func screenSize() -> ScreenSize {
        let size = UIScreen.main.nativeBounds.size
        let scale = UIScreen.main.nativeScale
        let width = Int(size.width / scale)
        let height = Int(size.height / scale)
        return (width, height)
    }

    public class func isNarrowScreen() -> Bool {
        return screenSize().width == kIphone5Width
    }
    
    public class func likeIphone5() -> Bool {
        return screenSize() == iPhone5Size
    }
    
    public class func likeIphone4() -> Bool {
        return screenSize() == iPhone4Size
    }
    
    public class func likeIphone6() -> Bool {
        return screenSize() == iPhone6Size
    }
    
    public class func likeIphone6P() -> Bool {
        return screenSize() == iPhone6PSize
    }

    public class func likeIphoneX() -> Bool {
        return screenSize() == iPhoneXSize
    }
    
    public class var smallerScreen: Bool {
        return screenSize().width <= iPhone6Size.width
    }
}
