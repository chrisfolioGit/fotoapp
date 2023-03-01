//
//  ImageResultModels.swift
//  FotoApp
//
//  Created by Christoph Wojciechowski on 28.02.23.
//

import Foundation

struct ImageResults: Codable {
    let hits: [ImageResult]
}

struct ImageResult: Codable, Identifiable {
    let id: Int
    let previewURL: String
    let largeImageURL: String
}
