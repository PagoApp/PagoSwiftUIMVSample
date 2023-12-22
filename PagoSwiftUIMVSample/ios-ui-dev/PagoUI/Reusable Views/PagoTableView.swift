//
//  PagoTableView.swift
//  Pago
//
//  Created by Gabi Chiosa on 26/08/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//

import UIKit
import Foundation

enum PagoTableViewType {
    case normal, rounded
}

internal struct PagoTableViewStyle {
    
    let type: PagoTableViewType
    let cornerRadius: CGFloat
    let cellInset: CGFloat
    
    init(type: PagoTableViewType) {
        
        self.type = type
        switch type {
        case .normal:
            cornerRadius = CGFloat(0)
            cellInset = CGFloat(0)
        case .rounded:
            cornerRadius = CGFloat(12)
            cellInset = CGFloat(16)
        }
    }
}

public class PagoTableView: UITableView {

    public var hasRoundedCorners: Bool = false {
        didSet {
            customStyle = PagoTableViewStyle(type: .rounded)
        }
    }
    
    private var customStyle = PagoTableViewStyle(type: .normal)

    public func roundTableView(_ tableView: UITableView, withCell cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard customStyle.type == .rounded, let baseCell = cell as? BaseTableViewCell else { return }
        baseCell.separatorInset = UIEdgeInsets(top: 0, left: customStyle.cellInset, bottom: 0, right: customStyle.cellInset)
         if baseCell.responds(to: #selector(getter: UIView.tintColor)) {
            let cornerRadius = customStyle.cornerRadius
            let cellInset = customStyle.cellInset
            baseCell.backgroundColor = UIColor.Pago.clear.color
            baseCell.contentView.backgroundColor = UIColor.Pago.clear.color
            let layer: CAShapeLayer = CAShapeLayer()
            let pathRef:CGMutablePath = CGMutablePath()
            let bounds: CGRect = baseCell.bounds.insetBy(dx: cellInset, dy: 0)
            if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1 {
                pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
            } else if indexPath.row == 0 {
                pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
                pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
                pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
                pathRef.addLine(to:CGPoint(x: bounds.maxX, y: bounds.maxY) )
            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1 {
                pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
                pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
                pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
                pathRef.addLine(to:CGPoint(x: bounds.maxX, y: bounds.minY) )
            } else {
                pathRef.addRect(bounds)
            }
            layer.path = pathRef
            layer.fillColor = baseCell.presenter.baseStyle.backgroundColorType.cgColor
            let backgroundView: UIView = UIView(frame: bounds)
            backgroundView.layer.insertSublayer(layer, at: 0)
            backgroundView.backgroundColor = UIColor.Pago.clear.color
            cell.backgroundView = backgroundView
        }
    }
}
