//
//  
//  PagoLoadingCell.swift
//  Pago
//
//  Created by Gabi Chiosa on 02.09.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit

public class PagoLoadingCell: BaseTableViewCell {
    
    var stackView: PagoStackedInfoView?
    
    private var cellPresenter: PagoLoadingCellPresenter {
        return (presenter as! PagoLoadingCellPresenter)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        
        let stackView = PagoStackedInfoView()
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            // constrain main stack view to all 4 sides of contentView
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
        
        self.stackView = stackView
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var presenter: BaseCellPresenter! {
        didSet {
            presenter.setView(mView: self)
            cellPresenter.loadData()
            contentView.backgroundColor = cellPresenter.baseStyle.backgroundColorType.color
        }
    }
}

extension PagoLoadingCell: PagoLoadingCellPresenterView {

    public func setup(stack: PagoStackedInfoPresenter) {

//        guard stackView == nil else { return }
        stackView?.setup(presenter: stack)
//        let stackView = PagoStackedInfoView(presenter: stack)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(stackView)
//        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        contentView.layoutIfNeeded()
//        self.stackView = stackView
    }
}
