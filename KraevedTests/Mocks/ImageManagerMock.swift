//
//  ImageManagerMock.swift
//  KraevedTests
//
//  Created by Владимир Амелькин on 21.12.2022.
//

import UIKit
@testable import Kraeved

class ImageManagerMock: ImageManagerProtocol {
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        completion(UIImage())
    }
}
