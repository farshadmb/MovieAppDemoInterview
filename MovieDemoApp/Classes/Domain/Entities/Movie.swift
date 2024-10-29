//
//  Movie.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation

struct Movie {
    
    let id: Int
    let title: String
    var status: String? = "Released"
    let releaseDate: String
    
    let overview: String
    
    let isAdult: Bool
    let hasVideo: Bool
    
    let originalLanguage: String
    let originalTitle: String
    
    let popularity: Double
    
    let backdropPath: String?
    let posterPath: String?
    
    let voteAverage: Double
    let voteCount: Int
    
    var budget: Int = 0
    var runtime: Int = 0
    
    init(id: Int, title: String, status: String? = nil,
         releaseDate: String, overview: String,
         isAdult: Bool, hasVideo: Bool,
         originalLanguage: String, originalTitle: String,
         popularity: Double,
         backdropPath: String?, posterPath: String?,
         voteAverage: Double, voteCount: Int,
         budget: Int = 0, runtime: Int = 0
        ) {
        self.id = id
        self.title = title
        self.status = status
        self.releaseDate = releaseDate
        self.overview = overview
        self.isAdult = isAdult
        self.hasVideo = hasVideo
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.popularity = popularity
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.budget = budget
        self.runtime = runtime
    }
    
}
