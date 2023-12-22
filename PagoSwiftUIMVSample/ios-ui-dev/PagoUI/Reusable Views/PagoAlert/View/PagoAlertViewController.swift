//
//  
//  PagoAlertViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

public class PagoAlertViewController: PagoBaseAlertViewController {
    
    var presenter: PagoAlertPresenter {
        return basePresenter as! PagoAlertPresenter
    }
    private var optionsStackView: PagoStackView!
    private var holderScroll: PagoScrollView!
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        holderScroll = PagoScrollView()
        holderScroll.delegate = self
        holderScroll.isScrollEnabled = true
        holderScroll.clipsToBounds = true
        holderScroll.backgroundColor = .white
        stackView.addArrangedSubview(holderScroll)
        
        optionsStackView = PagoStackView()
        if let space = presenter.style?.optionsSpace {
            optionsStackView.spacing = space
        }
        optionsStackView.axis = .vertical
        optionsStackView.alignment = .fill
        optionsStackView.distribution = .fill
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        holderScroll.addSubview(optionsStackView)
        optionsStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        optionsStackView.topAnchor.constraint(equalTo: holderScroll.topAnchor).isActive = true
        optionsStackView.leadingAnchor.constraint(equalTo: holderScroll.leadingAnchor).isActive = true
        optionsStackView.trailingAnchor.constraint(equalTo: holderScroll.trailingAnchor).isActive = true
        optionsStackView.bottomAnchor.constraint(equalTo: holderScroll.bottomAnchor, constant: -40).isActive = true
        let heightConstraint = optionsStackView.heightAnchor.constraint(equalTo: holderScroll.heightAnchor)
        heightConstraint.priority = UILayoutPriority(600)
        heightConstraint.isActive = true
        
        presenter.setView(mView: self)
        presenter.loadData()
    }

}

extension PagoAlertViewController: PagoAlertPresenterView {
    
    public func setup(button: PagoStackedInfoPresenter) {
        
        let view = PagoStackedInfoView(presenter: button)
        optionsStackView.addArrangedSubview(view)
    }
    
    public func setup(option: PagoStackedInfoPresenter, hasSeparator: Bool) {
        let horizontalMargins = CGFloat(PagoUIConfigurator.customConfig.buttons.marginHorizontal)
        let option = PagoStackedInfoView(presenter: option)
        option.backgroundColor = .white
        
        let optionHolder = UIView()
        optionHolder.backgroundColor = .white
        optionHolder.translatesAutoresizingMaskIntoConstraints = false
        optionHolder.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        optionHolder.addSubview(option)
        option.leadingAnchor.constraint(equalTo: optionHolder.leadingAnchor, constant: horizontalMargins).isActive = true
        option.trailingAnchor.constraint(equalTo: optionHolder.trailingAnchor, constant: -horizontalMargins).isActive = true
        option.centerYAnchor.constraint(equalTo: optionHolder.centerYAnchor).isActive = true
        option.topAnchor.constraint(greaterThanOrEqualTo: optionHolder.topAnchor).isActive = true

        if hasSeparator {
            let line = UIView()
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = UIColor.Pago.dividers.color
            line.heightAnchor.constraint(equalToConstant: 1).isActive = true
            optionHolder.addSubview(line)
            line.bottomAnchor.constraint(equalTo: optionHolder.bottomAnchor, constant: -1).isActive = true
            line.centerXAnchor.constraint(equalTo: optionHolder.centerXAnchor).isActive = true
            line.widthAnchor.constraint(equalTo: option.widthAnchor).isActive = true
        }
        
        optionsStackView.addArrangedSubview(optionHolder)
    }
    
    public func setupFooter() {
        
        stackView.addVerticalSpace(40)
        self.view.bringSubviewToFront(holderScroll)
    }
  
    public func setup(header: PagoStackedInfoPresenter) {
        
        let header = PagoStackedInfoView(presenter: header)
        let index = stackView.arrangedSubviews.count > 1 ? 1 : 0
        stackView.insertArrangedSubview(header, at: index)
        header.backgroundColor = .white
    }

    public func setup(datePicker: PagoDatePickerPresenter) {

        let view = PagoDatePicker(presenter: datePicker)
        optionsStackView.addArrangedSubview(view)
    }
}

extension PagoAlertViewController {

    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        guard scrollView.isDragging else { return }
        
        if scrollView == self.scrollView {
            let offset = Float(scrollView.contentOffset.y)
            if offset < 0 {
                let percent = min(abs(offset) / 50, 1)
                let value = CGFloat(0.5)
                let t: CGFloat = value - (CGFloat(percent) * value)
                view.backgroundColor = UIColor.Pago.blackWithAlpha(t).color
            }
        }
        
    }
    

    public override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        super.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
        if scrollView == self.scrollView {
            presenter.dismissView(offset: scrollView.contentOffset.y)
        }
    }

    public override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        super.scrollViewDidEndDecelerating(scrollView)
        if scrollView == self.scrollView {
            presenter.dismissView(offset: scrollView.contentOffset.y)
        }
    }
}
