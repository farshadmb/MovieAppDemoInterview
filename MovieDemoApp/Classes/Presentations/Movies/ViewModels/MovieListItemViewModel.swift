//
//  MovieListItemViewModel.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import RxDataSources

struct MovieListItemViewModel: IdentifiableType, Hashable {
   
    var identity: Int { id }
    var id: Int { model.id }
    var title: String { model.title }
    var releaseDate: String { model.releaseDate }
    var rating: String { String(model.voteAverage) }
    
    let model: Movie
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(rating)
        hasher.combine(releaseDate)
    }
    
    static func == (lhs: MovieListItemViewModel, rhs: MovieListItemViewModel) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title
            && lhs.releaseDate == rhs.releaseDate
            && rhs.model.voteAverage == lhs.model.voteAverage
    }
    
    func getPosterURL() -> URL? {
        guard let posterPath = model.posterPath else {
            return nil
        }
        return try? ImageUrlBuilder(baseURL: AppConfig.imageBaseURL)
            .imagePath(posterPath)
            .imageType(.poster, width: 150)
            .build()
    }
    
}
