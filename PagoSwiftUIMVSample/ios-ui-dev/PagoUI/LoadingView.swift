//
//  LoadingView.swift
//  Pago
//
//  Created by Mihai Arosoaie on 27/02/2017.
//  Copyright © 2017 timesafe. All rights reserved.
//

import UIKit
//TODO: Fix this
//import FLAnimatedImage

final class LoadingView: UIView {
    
    var view: LoadingView!

    var animationView: UIView!
    @IBOutlet var gifContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
        
    }
    
    func initialize() {

//        let animationView = CustomSuperAnimationView(frame: CGRect(x: 0, y: 0, width: 76, height: 76), radius: 32, lineWidth: 8, time: 5)
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        animationView.addUntitled1Animation()
//
//        gifContainer.addSubview(animationView)
//        gifContainer.layer.cornerRadius = 5.0
//        gifContainer.clipsToBounds = true
//        gifContainer.backgroundColor = .clear
//
//
//        animationView.centerXAnchor.constraint(equalTo: gifContainer.centerXAnchor).isActive = true
//        animationView.centerYAnchor.constraint(equalTo: gifContainer.centerYAnchor).isActive = true
//        animationView.widthAnchor.constraint(equalToConstant: 64).isActive = true
//        animationView.heightAnchor.constraint(equalToConstant: 64).isActive = true
//        animationView.clipsToBounds = false
//
//        self.bringSubview(toFront: gifContainer)
    }
    
    

    

    
}
