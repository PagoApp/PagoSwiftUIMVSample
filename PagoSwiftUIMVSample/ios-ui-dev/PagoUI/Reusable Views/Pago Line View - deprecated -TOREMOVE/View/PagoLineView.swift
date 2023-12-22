//
//  
//  PagoLineView.swift
//  Pago
//
//  Created by Gabi Chiosa on 31/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit

open class PagoLineView: BaseView {
        
    private let lineLayer: CALayer = CALayer()

    private var viewPresenter: PagoLinePresenter { return (presenter as! PagoLinePresenter) }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    public init(presenter: PagoLinePresenter) {
        
        super.init(frame: .zero)
        setup(presenter: presenter)
    }

    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    public func setup(presenter: PagoLinePresenter) {
        
        self.presenter = presenter
        presenter.setView(mView: self)
        setup()
    }
    
    private func setup() {

        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        reloadView()
    }
    
    public override func reloadView() {
        
        super.reloadView()
        let lineHeight = viewPresenter.style.height
        lineLayer.frame = CGRect(x:bounds.minX - viewPresenter.style.leftInset, y:bounds.size.height-lineHeight, width:bounds.size.width - viewPresenter.style.rightInset, height:lineHeight)
        lineLayer.backgroundColor = viewPresenter.style.color.cgColor
        if !(layer.sublayers?.contains(lineLayer) ?? false) {
            layer.addSublayer(lineLayer)
        }
    }
}
