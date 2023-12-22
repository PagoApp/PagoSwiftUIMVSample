//
//
//  PagoControllerView.swift
//  Pago
//
//  Created by Gabi Chiosa on 19/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import Foundation
import UIKit

public protocol PagoControllerDelegate: AnyObject {
    // NOTE: Add communication between cell and view controller if needed
}

public class PagoPageController: BaseView {
    
    private var pageController: BasePageControl!
    
    var viewPresenter: PagoPageControllerPresenter! {
        return (presenter as! PagoPageControllerPresenter)
    }
    weak var delegate: PagoControllerDelegate?
    
    
    public init(presenter: PagoPageControllerPresenter) {
        
        super.init(frame: .zero)
        self.presenter = presenter
        setup()
    }

    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public func setup(presenter: PagoPageControllerPresenter) {
        
        self.presenter = presenter
        setup()
    }

    private func setup() {
        
        pageController = BasePageControl(frame: .zero)
        pageController.numberOfPages = viewPresenter.numberOfPages
        self.backgroundColor = .clear
        pageController.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageController)
        pageController.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pageController.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pageController.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pageController.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        viewPresenter.setView(mView: self)
        pageController.pageIndicatorTintColor = viewPresenter.indicatorColorType.color
        pageController.currentPageIndicatorTintColor = viewPresenter.currentIndicatorColorType.color
        //TODO: Fix this
//        divider.color = viewPresenter.dividerColorType.color
    }
    
    public override func reloadView() {
        
        super.reloadView()
        pageController.currentPage = viewPresenter.currentIndex
    }
}
