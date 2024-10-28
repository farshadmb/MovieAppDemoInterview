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
              isAdult: adult,
              backdropPath: backdropPath,
              originalLanguage: originalLanguage,
              originalTitle: title,
              overview: overview,
              popularity: popularity,
              posterPath: posterPath,
              releaseDate: releaseDate,
              title: title,
              video: video,
              voteAverage: voteAverage,
              voteCount: voteCount)
    }
}
