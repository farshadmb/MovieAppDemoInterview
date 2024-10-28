//
//  AppConfig.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation

struct AppConfig {
    
    static let ApiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNzc1Nzk2MDJiMjU0YTcwYjhkNDkwNzc1N2YxOTcxMSIsIm5iZiI6MTczMDA4OTI4Ny41Njc5MzgsInN1YiI6IjY3MWYwZmEyMjY4NWNiNjU2M2MxNDE1ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fDM_7N5cpmsxOjEOcZHXver1dnlnMb-danMt77KjRm0"
    static let defaltPageSize = 10
    // swiftlint:disable:next force_unwrapping
    static let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    // swiftlint:disable:next force_unwrapping
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/")!
}
