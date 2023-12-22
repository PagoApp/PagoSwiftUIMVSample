//
//  
//  PagoDatePickerViewController.swift
//  Pago
//
//  Created by Gabi Chiosa on 03/06/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit

class PagoDatePicker: BaseView {

    private var datePicker: UIDatePicker!
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

    private var viewPresenter: PagoDatePickerPresenter! {
        return (presenter as! PagoDatePickerPresenter)
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public init(presenter: PagoDatePickerPresenter) {

        super.init(frame: .zero)
        setup(presenter: presenter)
    }

    public func setup(presenter: PagoDatePickerPresenter) {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.presenter = presenter
        self.presenter.setView(mView: self)
        setup()
    }

    private func setup() {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(datePicker)

        setupConstraints()

        guard let viewPresenter = viewPresenter else { return }
        datePicker.datePickerMode = viewPresenter.model.style.datePickerMode
        datePicker.backgroundColor = UIColor.white
        datePicker.date = viewPresenter.model.style.currentDate
        datePicker.minimumDate = viewPresenter.model.style.minDate
        datePicker.maximumDate = viewPresenter.model.style.maxDate
        datePicker.timeZone = viewPresenter.timeZone
        datePicker.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.locale = viewPresenter.model.style.locale

        layoutIfNeeded()
        viewPresenter.didUpdate()
    }

    private func setupConstraints() {

        guard let viewPresenter = viewPresenter else { return }
        datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewPresenter.style.inset.left).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewPresenter.style.inset.right).isActive = true
        datePicker.topAnchor.constraint(equalTo: self.topAnchor, constant: viewPresenter.style.inset.top).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -viewPresenter.style.inset.bottom).isActive = true
    }

    @objc private func dateDidChange(_ sender: UIDatePicker) {

        viewPresenter.selectedValue = sender.date
    }

}
