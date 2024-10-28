//
//  AppConfig.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation

struct AppConfig {
    
    static let ApiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3OGNmMzQ4ZTM0YTg3YWQxYjNkMDA3ODE4NWViMzk1MyIsInN1YiI6IjYzZDEyYzg2ZTcyZmU4MDA3Y2EzYThjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Z80TFxEEd-O03sr9r2IkJyYGMc5sWzapSEV4XpPObkQ"
    static let defaltPageSize = 10
    // swiftlint:disable:next force_unwrapping
    static let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    // swiftlint:disable:next force_unwrapping
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/")!
}
