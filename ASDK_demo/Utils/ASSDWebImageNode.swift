//
//  ASDKExtension.swift
//  HHUikit
//
//  Created by Shi Jian on 2017/8/24.
//  Copyright © 2017年 HH-Medic. All rights reserved.
//

import UIKit
import SDWebImage
import AsyncDisplayKit


public class ASSDWebImageNode: ASNetworkImageNode {
    
    public var manager: ImageManager?
    
    init() {
        
        manager = ImageManager()
        super.init(cache: manager, downloader: manager!)
    }
    
}

extension ASNetworkImageNode {

    public static func SDWebManager() -> ASNetworkImageNode {
    
        let manager = ImageManager()
        return ASNetworkImageNode(cache: manager, downloader: manager)
    }
}



// MARK: - image manager
public class ImageManager: NSObject  {
    
    public var manager = SDWebImageManager.shared()
    
    public var options: SDWebImageOptions = [.continueInBackground, .retryFailed]

}

extension ImageManager: ASImageCacheProtocol {

    // fetch an image with the given URL from the cache
    public func cachedImage(with URL: URL, callbackQueue: DispatchQueue, completion: @escaping ASImageCacherCompletion) {
        
        let cacheKey = manager.cacheKey(for: URL)
        manager.imageCache?.queryCacheOperation(forKey: cacheKey, done: { (image, data, type) in
            
            callbackQueue.async {
                completion(ImageContainer(image: image))
            }
        })
    }
    
    // fetch an image with the given URL from a memory cache
    public func synchronouslyFetchedCachedImage(with URL: URL) -> ASImageContainerProtocol? {
        let cacheKey = manager.cacheKey(for: URL)
        let image = manager.imageCache?.imageFromMemoryCache(forKey: cacheKey)
        
        return ImageContainer(image: image)
        
    }
    
    // Called during clearPreloadedData
    public func clearFetchedImageFromCache(with URL: URL) {
        
        let cacheKey = manager.cacheKey(for: URL)
        manager.imageCache?.removeImage(forKey: cacheKey, fromDisk: false, withCompletion: nil)
    }
}

extension ImageManager: ASImageDownloaderProtocol {

    // Downloads an image
    public func downloadImage(with URL: URL, callbackQueue: DispatchQueue, downloadProgress: ASImageDownloaderProgress?, completion: @escaping ASImageDownloaderCompletion) -> Any? {
        
        weak var weakOperator: SDWebImageOperation?
        let operation = manager.loadImage(with: URL, options: options, progress: { (receive, expect, url) in
            
            callbackQueue.async {
                
                downloadProgress?(CGFloat(receive/expect))
            }
            
        }) { (image, data, error, type, finishef, target) in
            
            completion(ImageContainer(image: image), error, weakOperator)
        }
        
        weakOperator = operation
        
        return operation
    }
    
    // Cancels an image download
    public func cancelImageDownload(forIdentifier downloadIdentifier: Any) {
        
        (downloadIdentifier as? SDWebImageOperation)?.cancel()
    }
}

// MARK: - imageContainer
public class ImageContainer: NSObject, ASImageContainerProtocol {

    var image: UIImage?
    
    public init(image: UIImage?) {
        
        self.image = image
    }
    
    public func asdk_image() -> UIImage? {
        
        return image
    }
    
    public func asdk_animatedImageData() -> Data? {
        
        return nil
    }
}
