//
//  PagoLottieAnimationWrapper.swift
//  PagoUISDK
//
//  Created by Gabi on 10.11.2023.
//

import Foundation
import UIKit


public protocol PagoLottieAnimationDataSource {

    var animationViewWrapper: UIView { get }
    func setupAnimation(view: UIView, animation: String, bundle: Bundle, loop: Bool)
    func play(view: UIView)
    func stop(view: UIView)
    func setupAnimation(view: UIView, animation urlString: String, animationPlaceholder: String, bundle: Bundle, loop: Bool)}

public protocol PagoSDWebImageDataSource {

    func loadImage(imageView: UIImageView, urlString: URL?, placeholderImage: UIImage?, completion: @escaping(UIImage?)->())
    
}
