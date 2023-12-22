//
//  
//   PagoStepCardView.swift
//  PagoRCASDK
//
//  Created by Gabi on 10.08.2022.
//

import PagoUISDK
import UIKit

public class PagoStepCardView: BaseView {
    
    private let tapAreaView = PagoView()
    
    var viewPresenter: PagoStepCardPresenter! {
        return (presenter as! PagoStepCardPresenter)
    }

    public init(presenter: PagoStepCardPresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }

    func setup(presenter: PagoStepCardPresenter) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.presenter = presenter
        presenter.setView(mView: self)
        presenter.loadData()
    }

}

extension PagoStepCardView: PagoStepCardPresenterView {

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
    
    public func hide(isHidden: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = isHidden
        }
    }
}
