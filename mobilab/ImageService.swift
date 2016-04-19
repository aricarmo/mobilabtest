//
//  ImageService.swift
//  mobilab
//
//  Created by Arilson do Carmo on 4/18/16.
//  Copyright © 2016 Arilson do Carmo. All rights reserved.
//

import UIKit

private let downloadQueue = dispatch_queue_create("com.arilsoncarmo.mobilab", nil)

class ImageService {
    var avatarCache: NSCache
    
    init() {
        avatarCache = NSCache()
    }
    func getAvatarCache(url: NSURL) -> UIImage? {
        if let img = avatarCache.objectForKey(url) as? UIImage {
            return img
        }
        return nil
    }
    
    /*
     *  Async method to load image..
     *  parameters: an url from image and callback to completion
     */
    func asyncLoadImageContent(imageURL: NSURL, completion: (image: UIImage) -> Void) {
        if verifyImageLink(imageURL) {
            dispatch_async(downloadQueue) { () -> Void in
                if let data = NSData(contentsOfURL: imageURL) {
                    let image = UIImage(data: data)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.avatarCache.setObject(image!, forKey: imageURL)
                        completion(image: image!)
                    }
                }
            }
        }
    }
    
    func verifyImageLink(link: NSURL) -> Bool {
        if String(link).rangeOfString("jpg") != nil || String(link).rangeOfString("png") != nil || String(link).rangeOfString("gif") != nil {
            return true
        } else {
            return false
        }
    }

}