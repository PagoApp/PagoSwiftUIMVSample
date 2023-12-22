////
////  ShowsLoadingView.swift
////  Pago
////
////  Created by Mihai Arosoaie on 27/02/2017.
////  Copyright © 2017 timesafe. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//protocol ShowsLoadingView: AnyObject {
//}
//
//private var LoadingViewAssociationKey =  "LoadingViewAssociationKey"
//
//extension ShowsLoadingView where Self: UIViewController {
//    
//    var loadingView: UIView? {
//        get {
//            return objc_getAssociatedObject(self, &LoadingViewAssociationKey) as? UIView
//        }
//        set {
//            objc_setAssociatedObject(self, &LoadingViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//    
//    func showLoadingView() {
//        guard self.loadingView == nil else {return}
//        
//        var parentView = self.view
//
//        if self is UITableViewController {
//            parentView = self.view.superview
//        }
//        let loadingView = LoadingView.fromNib()
//        parentView?.addSubview(loadingView)
//        loadingView.translatesAutoresizingMaskIntoConstraints = false
//        _ = loadingView.fillSuperView()
//        self.loadingView = loadingView
//    }
//    
//    func hideLoadingView() {
//        guard let loadingView = self.loadingView else {return}
//        loadingView.removeFromSuperview()
//        self.loadingView = nil
//    }
//    
//}
//
//extension UINavigationController: ShowsLoadingView {
//
//}
