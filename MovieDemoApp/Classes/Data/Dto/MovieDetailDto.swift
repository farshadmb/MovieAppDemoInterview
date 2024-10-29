//
//  MovieDetailDto.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import Foundation

struct MovieDetailDto: Decodable {
    
    let id: Int
    let title: String
    let backdropPath: String?
    let adult: Bool
    let budget: Int
    let genres: [GenreDto]
    let homepage: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let runtime: Int
    let status: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime = "runtime"
        case status = "status"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension MovieDetailDto {
    
    struct GenreDto: Codable {
        
        let id: Int
        let name: String
    }
    
}
