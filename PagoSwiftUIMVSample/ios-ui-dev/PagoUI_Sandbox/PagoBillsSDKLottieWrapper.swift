//
//  File.swift
//  
//
//  Created by Gabi on 14.11.2023.
//

import UIKit
import Lottie
import PagoUISDK

public class PagoLottieAnimationWrapper: PagoLottieAnimationDataSource {
    
    public func play(view: UIView) {
        
        guard let lottieView = (view as? LottieAnimationView) else { return }
        lottieView.play()
    }
    
    public func stop(view: UIView) {
        
        guard let lottieView = (view as? LottieAnimationView) else { return }
        lottieView.stop()
    }
    
   
    public var animationViewWrapper: UIView {
       
        let animationView = LottieAnimationView()
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = .pauseAndRestore
        return animationView
    }


    public func setupAnimation(view: UIView, animation: String, bundle: Bundle, loop: Bool) {
        
        guard let lottieView = (view as? LottieAnimationView) else { return }
        lottieView.animation = LottieAnimation.named(animation, bundle: bundle)
        lottieView.loopMode = loop ? .loop : .playOnce
        lottieView.play()
    }
    
    public func setupAnimation(view: UIView, animation urlString: String, animationPlaceholder: String, bundle: Bundle, loop: Bool) {
        
        guard let lottieView = (view as? LottieAnimationView) else { return }
        
        if let url = URL(string: urlString) {
            LottieAnimation.loadedFrom(url: url, closure: { remoteAnimation in
                if (remoteAnimation != nil) {
                    lottieView.animation = remoteAnimation
                } else {
                    lottieView.animation = LottieAnimation.named(animationPlaceholder, bundle: bundle)
                }
                lottieView.play()
            }, animationCache: DefaultAnimationCache.sharedCache)
        } else {
            lottieView.animation = LottieAnimation.named(animationPlaceholder, bundle: bundle)
        }
        lottieView.loopMode = loop ? .loop : .playOnce
    }

}

