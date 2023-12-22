//
//  
//  PagoSearchBarView.swift
//  Pago
//
//  Created by Gabi Chiosa on 30/07/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public protocol PagoSearchBarDelegate: AnyObject {
    
    func searchBarDidSearch(_ text: String?)
    func searchBarDidClear()
    func searchBarDidStart()
    func searchBarDidStop()
}

open class PagoSearchBarView: BaseView {
        
    public weak var delegate: PagoSearchBarDelegate?
    
    private let searchIndicator: UIImageView
    private let textField: UITextField
    
    private var presenterView: PagoSearchBarPresenter {
        return presenter as! PagoSearchBarPresenter
    }

    public init(presenter: PagoSearchBarPresenter) {
        
        self.searchIndicator = UIImageView()
        self.textField = UITextField()
        super.init(frame: .zero)
        self.presenter = presenter
        presenter.setView(mView: self)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        
        self.searchIndicator = UIImageView()
        self.textField = UITextField()
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        
        self.layer.cornerRadius = CGFloat(presenterView.style.cornerRadius)
        self.layer.borderWidth = CGFloat(presenterView.style.borderWidth)
        self.layer.borderColor = presenterView.style.borderColor.cgColor
        self.clipsToBounds = true
        
        searchIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchIndicator)
        searchIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        searchIndicator.heightAnchor.constraint(equalToConstant: 16).isActive = true
        searchIndicator.widthAnchor.constraint(equalToConstant: 16).isActive = true
        searchIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        searchIndicator.image = presenterView.image
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        
        textField.leadingAnchor.constraint(equalTo: searchIndicator.trailingAnchor, constant: 8).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.attributedPlaceholder = NSAttributedString(string: presenterView.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: presenterView.style.placeholderTextColor.color, .font : presenterView.style.placeholderFont.font])
        textField.delegate = self
        textField.clearButtonMode = .always
        loadData()
    }
    
        
    private func loadData() {
        
        textField.text = presenterView.text
    }
    
    override public func reloadView() {
        
        super.reloadView()
        loadData()
    }
}

extension PagoSearchBarView: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
     
        delegate?.searchBarDidStart()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        delegate?.searchBarDidStop()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text: NSString = textField.text! as NSString
        let finalString = text.replacingCharacters(in: range, with: string)
        
        delegate?.searchBarDidSearch(finalString)
        return true
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        delegate?.searchBarDidClear()
        textField.text = ""
        textField.resignFirstResponder()
        return false
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

extension PagoSearchBarView: PagoSearchBarPresenterView {

}
