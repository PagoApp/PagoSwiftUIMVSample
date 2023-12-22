//
//  
//  PagoWebModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 05.10.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct PagoWebModel: Model {
    
    public var htmlString: String?
    public var urlString: String?
    public var url: URL?
    public var type: PagoWebDisplayType = .remote
    
    public lazy var urlRequest: URLRequest? = {
        switch type {
        case .remote:
            if let urlString = urlString,
               let remoteUrl = URL(string: urlString) {
                let request = URLRequest(url: remoteUrl)
                return request
            }
        case .local:
            if let localUrl = url {
                let request = URLRequest(url: localUrl)
                return request
            }
        }
        return nil
    }()
        
    public lazy var loaderModel: PagoLoadedAnimationModel = {
        let animation = PagoDataAnimation(animation: .loading)
        let animationModel = PagoLoadedAnimationModel(animationType: animation, loop: true, style: PagoAnimationStyle(size: CGSize(width: 60, height: 60)))
        return animationModel
    }()
    
    public init(htmlString: String) {
        
        self.htmlString = htmlString
        self.type = .remote
    }
    
    public init(urlString: String) {

        self.urlString = urlString
        self.type = .remote
    }

    public init(localUrl: URL) {

        self.url = localUrl
        self.type = .local
    }
}

public enum PagoWebDisplayType {
    case remote,
         local
}
