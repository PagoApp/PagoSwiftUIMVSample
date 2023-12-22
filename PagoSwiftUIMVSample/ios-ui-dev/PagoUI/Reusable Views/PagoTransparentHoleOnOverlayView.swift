//
//  PagoTransparentHoleOnOverlayView.swift
//  Pago
//
//  Created by Gabi Chiosa on 21/04/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import Foundation
import UIKit

class PagoTransparentHoleOnOverlayView: UIView {

    var holeFrame: CGRect!

    // MARK: - Drawing

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        if self.holeFrame != nil && self.holeFrame != .zero {
            // Ensures to use the current background color to set the filling color
            self.backgroundColor?.setFill()
            UIRectFill(rect)

            let layer = CAShapeLayer()
            let path = CGMutablePath()

            // Make hole in view's overlay
            // NOTE: Here, instead of using the transparentHoleView UIView we could use a specific CFRect location instead...
//            var roundRect = UIBezierPath(roundedRect: holeFrame, byRoundingCorners:.allCorners, cornerRadii: CGSize(width: 16, height: 16))
//            path.addPath(roundRect)
//            path.addRect(holeFrame)
            path.addRoundedRect(in: holeFrame, cornerWidth: 12, cornerHeight: 12)
            path.addRect(bounds)

            layer.path = path
            layer.fillRule = CAShapeLayerFillRule.evenOdd
            self.layer.mask = layer
        }
    }

    override func layoutSubviews () {
        super.layoutSubviews()
    }

    // MARK: - Initialization

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
