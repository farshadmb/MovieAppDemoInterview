//
//  MovieListItemViewModel.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import RxDataSources

struct MovieListItemViewModel: IdentifiableType, Equatable {
   
    var identity: Int { id }
    var id: Int { model.id }
    var title: String { model.title }
    var releaseDate: String { model.releaseDate }
    var rating: String { String(model.voteAverage) }
    
    let model: Movie
    
    static func == (lhs: MovieListItemViewModel, rhs: MovieListItemViewModel) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title
            && lhs.releaseDate == rhs.releaseDate
            && rhs.model.voteAverage == lhs.model.voteAverage
    }
    
}
