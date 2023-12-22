//
//  
//  PagoBannerView.swift
//  PagoRCASDK
//
//  Created by Gabi on 13.10.2022.
//

import UIKit

public class PagoBannerView: BaseView {
    
    var viewPresenter: PagoBannerPresenter! {
        return (presenter as! PagoBannerPresenter)
    }

    public init(presenter: PagoBannerPresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }

    func setup(presenter: PagoBannerPresenter) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.presenter = presenter
        presenter.setView(mView: self)
        presenter.loadData()
    }

}

extension PagoBannerView: PagoBannerPresenterView {

    public func setup(presenter: PagoStackedInfoPresenter) {

        self.removeAllSubviews()
        let stack = PagoStackedInfoView(presenter: presenter)
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
    }
}
