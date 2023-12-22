//
//  BaseLine.swift
//  Pago
//
//  Created by Gabi Chiosa on 28/05/2020.
//  Copyright © 2020 cleversoft. All rights reserved.
//
import UIKit
import Foundation

class BaseLine: UIView {
    
    var color: UIColor?
    var offsetX: CGFloat = 0
    var lineHeight: CGFloat = 0.5
    private let bezierLine = UIBezierPath()
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        let width = frame.size.width
        bezierLine.move(to: CGPoint(x:offsetX, y:0))
        bezierLine.addLine(to: CGPoint(x: width, y: 0))
        bezierLine.close()
        (color ?? UIColor.lightGray).set()
        bezierLine.lineWidth = lineHeight
        bezierLine.stroke()
    }
}
