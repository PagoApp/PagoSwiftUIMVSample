//
//  File.swift
//  
//
//  Created by Gabi on 14.11.2023.
//

import UIKit
import SDWebImage
import PagoUISDK

public class PagoSDWebImageWrapper: PagoSDWebImageDataSource {
    
    public func loadImage(imageView: UIImageView, urlString: URL?, placeholderImage: UIImage?, completion: @escaping(UIImage?)->()) {
        
        imageView.sd_setImage(with: urlString, placeholderImage: placeholderImage) { (image, _, _, _) in
            completion(image)
        }
    }
}
