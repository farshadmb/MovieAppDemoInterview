//
//  MovieListViewModel.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxSwiftExt

class MovieListViewModel {
   
    let movieListUsecase: MovieListUsecase
    let disposeBag = DisposeBag()
    
    private let movies = BehaviorRelay<[Movie]>(value: [])
    private let loading = BehaviorRelay(value: false)
    private let error = PublishRelay<String>()
    private var page = 0
    
    init(movieListUsecase: MovieListUsecase) {
        self.movieListUsecase = movieListUsecase
    }
    
    func fetchMovieListIfNeeded() {
        guard movies.value.count == 0,
              loading.value == false else { return }
        fetchMovies(page: 0)
    }
    
    func loadMoreMovies() {
        guard loading.value == false else { return }
        fetchMovies(page: page + 1)
    }
    
    private func fetchMovies(page: Int) {
        loading.accept(true)
        let source = self.movieListUsecase.getMovieList(page: page, size: 0)
            .asObservable().share(replay: 1)
            .mapToResult()
            .do(onCompleted: {[weak loading] in loading?.accept(false) })
        source.compactMap(\.success).bind(with: self) { (self, movies) in
            self.page = page
            self.movies.accept(self.movies.value + movies)
        }.disposed(by: disposeBag)
        source.compactMap(\.failure).bind(with: self) { (self, error) in
            self.error.accept(error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
}
