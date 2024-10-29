//
//  DTOMapper.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation

protocol DTOMapper {
    
    associatedtype EntityType
    
    func toDomain() -> EntityType
}

extension MovieDto: DTOMapper {
    
    func toDomain() -> Movie {
        Movie(id: id,
              title: title,
              releaseDate: releaseDate,
              overview: overview,
              isAdult: adult,
              hasVideo: video,
              originalLanguage: originalLanguage,
              originalTitle: title,
              popularity: popularity,
              backdropPath: backdropPath,
              posterPath: posterPath,
              voteAverage: voteAverage,
              voteCount: voteCount)
    }
}

extension MovieDetailDto: DTOMapper {
    
    func toDomain() -> Movie {
        Movie(id: id,
              title: title,
              releaseDate: releaseDate,
              overview: overview,
              isAdult: adult,
              hasVideo: video,
              originalLanguage: originalLanguage,
              originalTitle: title,
              popularity: popularity,
              backdropPath: backdropPath,
              posterPath: posterPath,
              voteAverage: voteAverage,
              voteCount: voteCount,
              budget: budget,
              runtime: runtime
        )
    }
}
