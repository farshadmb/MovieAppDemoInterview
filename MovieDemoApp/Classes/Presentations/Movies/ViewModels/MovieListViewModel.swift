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
  
    typealias SectionType = AnimatableSectionModel<Int, MovieListItemViewModel>
    
    let movieListUsecase: MovieListUsecase
    let disposeBag = DisposeBag()
   
    var items: Driver<[SectionType]> {
        return movies.asDriver().map { items in
            [SectionType(model: 0, items: items)]
        }
    }
    
    var isLoading: Driver<Bool> { loading.asDriver() }
    
    var didErrorOccured: Driver<String> { error.asDriver(onErrorDriveWith: .never()) }
   
    typealias MovieSelectionClosure = (Movie) -> Void
    
    var didSelectMovie: MovieSelectionClosure?
    
    private let movies = BehaviorRelay<[SectionType.Item]>(value: [])
    private let loading = BehaviorRelay(value: false)
    private let error = PublishRelay<String>()
    private var page = 1
   
    deinit {
        didSelectMovie = nil
    }
    
    init(movieListUsecase: MovieListUsecase) {
        self.movieListUsecase = movieListUsecase
    }
    
    func fetchMovieListIfNeeded() {
        guard movies.value.count == 0,
              loading.value == false else { return }
        fetchMovies(page: 1)
    }
    
    func loadMoreMovies() {
        guard loading.value == false else { return }
        fetchMovies(page: page + 1)
    }
    
    func loadMoreMovies(afterIndex index: Int) {
        guard index + 1 >= movies.value.count else {
            return
        }
        loadMoreMovies()
    }
    
    func retryFetchMovie() {
        guard loading.value == false else { return }
        let nextStep = movies.value.count == 0 ? 0 : 1
        fetchMovies(page: page + nextStep)
    }
    
    func selectMovie(atIndex index: Int) {
        guard let viewModel = movies.value[safe: index] else {
            return
        }
        didSelectMovie?(viewModel.model)
    }
    
    private func fetchMovies(page: Int) {
        loading.accept(true)
        let loadingBlock: (Any) -> Void = { [weak loading] _ in loading?.accept(false) }
        let source = self.movieListUsecase.getMovieList(page: page, size: 0)
            .asObservable().share(replay: 1)
            .mapToResult()
            .do(onNext: loadingBlock, onError: loadingBlock)
        source.compactMap(\.success).bind(with: self) { (self, movies) in
            self.page = page
            var newItems = [MovieListItemViewModel]()
            for vModel in self.movies.value + movies.map(MovieListItemViewModel.init) {
                newItems.append(unique: vModel)
            }
            self.movies.accept(newItems)
        }.disposed(by: disposeBag)
        source.compactMap(\.failure).bind(with: self) { (self, error) in
            self.error.accept(error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
}
