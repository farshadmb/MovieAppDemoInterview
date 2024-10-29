//
//  UImageView+ImageDownloader.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import Foundation
import SDWebImage
import UIKit

extension UIImageView {

    /// The Default Image Options
    static let defaultSDWebImageOptions: SDWebImageOptions = [.lowPriority,.scaleDownLargeImages,.retryFailed,.transformAnimatedImage]

    /// The Cachable Image Options
    static let cacheSDWebImageOptions: SDWebImageOptions = [.lowPriority,.scaleDownLargeImages,.queryMemoryData,.refreshCached]

    /**
     Set the imageView `image` with an `url`, placeholder and custom options.
     
     - Seealso: `SDWebImageOptions`
     */
    func setImage(url: URL?, placeHolderImage: UIImage? = nil,
                  contentMode: UIView.ContentMode? = .scaleAspectFill,
                  options: SDWebImageOptions = UIImageView.defaultSDWebImageOptions,
                  completed: SDExternalCompletionBlock? = nil) {

        if let contentMode = contentMode {
            self.contentMode = contentMode
            self.setNeedsDisplay()
        }

        self.sd_setImage(with: url, placeholderImage: placeHolderImage,
                         options: options, completed: completed)
    }

    /**
     Cancel the current image load.
     */
    func cancelCurrentImageLoad() {
        sd_cancelCurrentImageLoad()
    }

}
