//
//  
//  PagoStackedInfosView.swift
//  PagoUI_Sandbox
//
//  Created by Gabi on 21.11.2023.
//

import PagoUISDK
import UIKit

internal class PagoStackedInfosView: BaseView {
    
    private let tapAreaView = PagoView()
    
    internal var viewPresenter: PagoStackedInfosPresenter! {
        return (presenter as! PagoStackedInfosPresenter)
    }

    internal init(presenter: PagoStackedInfosPresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }
    
    internal override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    internal required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }

    internal func setup(presenter: PagoStackedInfosPresenter) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.presenter = presenter
        presenter.setView(mView: self)
        presenter.loadData()
    }

}

extension PagoStackedInfosView: PagoStackedInfosPresenterView {

    internal func setup(presenter: PagoStackedInfoPresenter) {

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
