//
//  AppConfig.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation

struct AppConfig {
   
    #error("put your api key here")
    static let ApiKey = "YOUR-API-KEY"
    static let defaltPageSize = 10
    // swiftlint:disable:next force_unwrapping
    static let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    // swiftlint:disable:next force_unwrapping
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/")!
}
