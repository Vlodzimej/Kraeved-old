//
//  Settings.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 03.07.2023.
//

import Foundation

final class Settings {
    
    var hostURL: String {
        #if DEBUG
        return "127.0.0.11"
        #elseif LOCAL_DEV
        return "127.0.0.12"
        #else
        return "127.0.0.13"
        #endif
    }
    
    static let shared = Settings()
}
