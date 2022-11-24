//
//  ImageManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.11.2022.
//

import UIKit

protocol ImageManagerProtocol: AnyObject {
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

class ImageManager: ImageManagerProtocol {
    
    static let shared = ImageManager()
    
    let urlCache = URLCache.shared
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: url)
        if let data = urlCache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            completion(image)
        } else {
            print("Download Started")
            apiManager.getData(from: url) { [weak self] data, response, error in
                guard error == nil, let self = self, let data = data, let response = response, let image = UIImage(data: data) else { return }
                let cacheData = CachedURLResponse(response: response, data: data)
                self.urlCache.storeCachedResponse(cacheData, for: request)
                print(response.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                completion(image)
            }
        }
    }
}
