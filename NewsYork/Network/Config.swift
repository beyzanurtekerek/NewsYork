//
//  Config.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 26.02.2025.
//

import Foundation

struct Config {
    static let apiKey: String = {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path),
              let apiKey = config["NYT_API_KEY"] as? String else {
            fatalError("Config.plist dosyası veya NYT_API_KEY bulunamadı!")
        }
        return apiKey
    }()
}
