//
//  PagoBadgeRepository.swift
//  Pago
//
//  Created by Gabi Chiosa on 12/04/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import Foundation

public class PagoBadgeRepository: BaseRepository<PagoBadgePredicate, PagoBadgeModel> {

    override public func getData(predicate: PagoBadgePredicate, completion: @escaping (PagoBadgeModel) -> ()) {
        
        let badgeStyle = PagoLabelStyle(textColorType: predicate.textColor, fontType: .medium15, backgroundColorType: .clear, alignment: .center, numberOfLines: 1)
        let badgeModel = PagoLabelModel(text: predicate.text, style: badgeStyle)
        DispatchQueue.main.async {
            completion(PagoBadgeModel(badge: badgeModel))
        }
    }
  
}
