//
//  
//  EmptyScreenCell.swift
//  Pago
//
//  Created by Gabi Chiosa on 15/03/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//


class EmptyScreenCell: BaseTableViewCell {
    

    var cellPresenter: EmptyScreenCellPresenter {
        return (presenter as! EmptyScreenCellPresenter)
    }
    
    override var presenter: BaseCellPresenter! {
        didSet {
            cellPresenter.setView(mView: self)
            cellPresenter.loadData()
            contentView.backgroundColor = cellPresenter.baseStyle.backgroundColorType.color
        }
    }
}

extension EmptyScreenCell: EmptyScreenCellPresenterView {
    
    func setup(empty: EmptyScreenPresenter) {
        
        let emptyScreen = PagoEmptyScreenView.fromNib(presenter: empty)
        emptyScreen.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(emptyScreen)
        emptyScreen.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        emptyScreen.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        emptyScreen.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        emptyScreen.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
}

