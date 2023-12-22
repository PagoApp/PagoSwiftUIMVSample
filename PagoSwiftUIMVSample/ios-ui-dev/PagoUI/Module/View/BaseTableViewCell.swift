//
//  BaseTableViewCell.swift
//  Pago
//
//  Created by Bogdan-Gabriel Chiosa on 09/12/2019.
//  Copyright © 2019 cleversoft. All rights reserved.
//
import UIKit
import Foundation

open class BaseTableViewCell: UITableViewCell, PresenterView {
    
    open var presenter: BaseCellPresenter!
    
    open func reloadView() {
        self.backgroundColor = PagoThemeStyle.custom.secondaryBackgroundColor.color
    }
    
    public func removeAllSubviews() {
        for v in contentView.subviews {
            v.removeFromSuperview()
        }
    }
}

open class BaseTableViewHeaderFooterCell: UITableViewHeaderFooterView, PresenterView {
    
    open var presenter: BasePresenter!
    
    open func reloadView() {}
}
