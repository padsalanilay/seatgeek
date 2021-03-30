//
//  ImageCacheManager.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import Foundation
import UIKit

protocol Cache {
    subscript(_ url: URL) -> UIImage? { get set }
}

class ImageCache: Cache {
    
    static let shared = ImageCache()
    
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get {
            cache.object(forKey: key as NSURL)
        }
        set {
            newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL)
        }
    }
    
    /// Remove all the images from the cache
    func clearCache() {
        self.cache.removeAllObjects()
    }
}
