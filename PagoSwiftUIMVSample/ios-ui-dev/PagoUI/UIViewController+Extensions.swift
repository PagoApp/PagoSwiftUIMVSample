//
//  UIViewController+Extensions.swift
//  Pago
//
//  Created by Mihai Arosoaie on 16/01/17.
//  Copyright © 2017 timesafe. All rights reserved.
//

import Foundation
import UIKit

internal extension UIViewController {
    
    enum StoryboardName: String {
        case main = "Main",
            faq = "FAQ",
            development = "Development",
            settings = "SettingsStoryboard",
            feedback = "FeedbackStoryboard",
            freemium = "Freemium",
            referral = "ReferralStoryboard",
            card = "CardStoryboard",
            donate = "Donate",
            taxesFees = "TaxesFees",
            providers = "ProvidersStoryboard"
    }
    
    convenience init(bundle: Bundle?) {
        self.init(nibName: String(describing: type(of: self)), bundle: bundle)
    }
    
    class func fromMainStoryboard() -> Self {
        return fromStoryboard(.main)
    }
    
    class func fromSettingsStoryboard() -> Self {
        return fromStoryboard(.settings)
    }
    
    class func fromReferralStoryboard() -> Self {
        return fromStoryboard(.referral)
    }

    class func fromFeedbackStoryboard() -> Self {
        return fromStoryboard(.feedback)
    }

    class func fromFreemiumStoryboard() -> Self {
        return fromStoryboard(.freemium)
    }
    
    class func fromDonateStoryboard() -> Self {
        return fromStoryboard(.donate)
    }

    class func fromCardStoryboard() -> Self {
        return fromStoryboard(.card)
    }
    
    class func fromTaxesFeesStoryboard() -> Self {
        return fromStoryboard(.taxesFees)
    }

    class func fromStoryboard(_ name: StoryboardName) -> Self {
        return instantiateFromStoryboard(named: name.rawValue)
    }
    
    class func fromStoryboard(named name: String) -> Self {
        return instantiateFromStoryboard(named: name)
    }
    
    private class func instantiateFromStoryboard<T>(named name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    public class func fromNib() -> Self {
        return instantiateFromNib()
    }
    
    class func instantiateFromNib<T>() -> T where T: UIViewController {

        let bundle = Bundle(for: T.self)
        return T.init(nibName: String(describing: T.self), bundle: bundle)
    }
    
    func isVisible() -> Bool {
        return (isViewLoaded && view.window != nil)
    }
    
}

internal extension BaseViewController {
    static func instantiateFromStoryboard(named name: StoryboardName, presenter: ViewControllerPresenter) -> Self {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! BaseViewController
        vc.basePresenter = presenter
        return vc as! Self
    }
}

internal extension UIViewController {
    func getTheParentInsideTheNavigationController() -> UIViewController? {
        guard let navigationController = self.navigationController else {return nil}
        if navigationController.viewControllers.contains(self) {
            return self
        } else {
            return self.parent?.getTheParentInsideTheNavigationController()
        }
    }
}

@nonobjc internal extension UIViewController {
    func addChild(_ child: UIViewController, container: UIView, frame: CGRect? = nil) {
        child.view.frame = frame != nil ? frame! : container.frame
        container.addSubview(child.view)
        addChild(child)
        child.didMove(toParent: self)
    }
    
    func removeAsChild() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
