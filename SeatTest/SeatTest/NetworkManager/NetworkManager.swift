//
//  NetworkManager.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import Foundation
import UIKit

class NetworkManger {
    typealias completion = (_ data: Data?, _ error: Error?) -> Void
    typealias completionImage = (_ image: UIImage) -> Void

    func load(url: URL, completion: @escaping completion) {
        DispatchQueue.global(qos: .background).async {
            let urlSession = URLSession.shared
            let task = urlSession.dataTask(with: url) { (data, response, error) in
                
                // check if the url provides success response
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(nil, APIError.invalidServerResponseError)
                    return
                }
                
                // check if there is any error in api call
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                // check if the data is empty
                guard let data = data else {
                    completion(nil, APIError.emptyDataError)
                    return
                }
                
                // send the data with completion handler
                completion(data, nil)
            }
            task.resume()
        }
    }
    
    func loadImage(from urlString: String, completion: @escaping completionImage) {
                
        let placeHolderImage: UIImage = UIImage(named: "eventplaceholder")!
        
        // check if the url is valid
        guard let url = URL(string: urlString) else {
            completion(placeHolderImage)
            return
        }
        
        // check cache for image, if available return the image from cache
        let cache = ImageCache.shared
        
        if let uiImage = cache[url] {
            completion(uiImage)
            return
        }
        
        // download the image from url request
        self.load(url: url) { (data, error) in
            // if empty data or error occurs
            guard error == nil ,let data = data, let image = UIImage(data: data) else {
                completion(placeHolderImage)
                return
            }
            
            // add image to chache
            cache[url] = image
            
            completion(image)
        }
    }
}

