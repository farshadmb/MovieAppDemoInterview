//
//  ImageUrlBuilder.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import Foundation

struct ImageUrlBuilder {
    
    let baseURL: URL
    var imagePath: String?
    var imageType: TmdbImageType?
    var width: CGFloat = 300
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func imagePath(_ imagePath: String) -> Self {
        var copy = self
        copy.imagePath = imagePath
        return copy
    }
    
    func imageType(_ imageType: TmdbImageType) -> Self {
        var copy = self
        copy.imageType = imageType
        return copy
    }
    
    func imageType( _ imageType: TmdbImageType, width: CGFloat = 500) -> Self {
        var copy = self
        copy.imageType = imageType
        copy.width = width
        return copy
    }

    func build() throws -> URL {
        guard var imagePath = imagePath else {
            throw ImageUrlBuilderError.missingImagePath
        }
        
        guard let imageType = imageType else {
            throw ImageUrlBuilderError.missingImageType
        }
        
        let imageSize = imageType.size(forWidth: width)
        if !imagePath.starts(with: "/") {
            imagePath = "/" + imagePath
        }
        
        let fullPath = baseURL.absoluteString + imageSize + imagePath
        guard let url = URL(string: fullPath) else {
            throw URLError(.badURL)
        }
        return url
    }
    
}

extension ImageUrlBuilder {
    
    enum ImageUrlBuilderError: LocalizedError {
        case missingImagePath
        case missingImageType
        
        var localizedDescription: String {
            switch self {
            case .missingImagePath:
                "The image path is missed"
            case .missingImageType:
                "The image type is missed"
            }
        }
        
        var errorDescription: String? { localizedDescription }
    }
    
    enum TmdbImageType: Int {
        case poster, backdrop
        
        var sizes: [String] {
            switch self {
            case .poster:
                ["w92", "w154", "w185", "w342", "w500", "w780"]
            case .backdrop:
                ["w185", "w300", "w500", "w780", "w1280"]
            }
        }
        
        fileprivate func size(forWidth width: CGFloat) -> String {
            switch self {
            case .poster where width <= 92:
                return sizes[0]
            case .poster where width <= 154:
                return sizes[1]
            case .poster where width <= 185:
                return sizes[2]
            case .poster where width <= 342:
                return sizes[3]
            case .poster where width <= 500:
                return sizes[sizes.count - 2]
            case .poster where width <= 780:
                return sizes[sizes.count - 1]
            case .poster:
                return sizes[sizes.count - 1]
            case .backdrop where width <= 185:
                return sizes[0]
            case .backdrop where width <= 300:
                return sizes[1]
            case .backdrop where width <= 500:
                return sizes[2]
            case .backdrop where width <= 780:
                return sizes[3]
            case .backdrop where width <= 1280:
                return sizes[sizes.count - 1]
            case .backdrop:
                return sizes[sizes.count - 1]
            }
        }
    }
}
