//
//  
//  PagoInformativeView.swift
//  PagoUISDK
//
//  Created by Gabi on 10.08.2022.
//

import UIKit

public class PagoInformativeView: BaseView {
    
    private let tapAreaView = PagoView()
    
    var viewPresenter: PagoInformativePresenter! {
        return (presenter as! PagoInformativePresenter)
    }

    public init(presenter: PagoInformativePresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }

    public func setup(presenter: PagoInformativePresenter) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.presenter = presenter
        presenter.setView(mView: self)
        presenter.loadData()
    }

}

extension PagoInformativeView: PagoInformativePresenterView {

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
