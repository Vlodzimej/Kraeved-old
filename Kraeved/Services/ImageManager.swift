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
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        print("Download Started")
        apiManager.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
//            DispatchQueue.main.async() { [weak self] in
//                self?.imageView.image = UIImage(data: data)
//            }
            let image = UIImage(data: data)
            completion(image)
        }
    }
}
