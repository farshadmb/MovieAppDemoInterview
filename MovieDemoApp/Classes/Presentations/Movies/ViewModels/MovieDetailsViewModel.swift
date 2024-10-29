//
//  MovieDetailsViewModel.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

final class MovieDetailsViewModel {
    
    var output: Driver<Output> {
        return infos.asDriver().unwrap()
    }
    
    var isLoading: Driver<Bool> { loading.asDriver() }
    
    var error: Driver<String> { errorSub.asDriver(onErrorDriveWith: .never()) }
    
    private var movieId: Int?
    private var entity: Movie?
    
    private var infos = BehaviorRelay<Output?>(value: nil)
    private var loading = BehaviorRelay(value: false)
    private var errorSub = PublishRelay<String>()
    private var isFetched = false
    
    let usecase: MovieDetailUsecase
    
    let disposeBag = DisposeBag()
    
    init(entity: Movie, useCase: MovieDetailUsecase) {
        self.entity = entity
        self.usecase = useCase
    }
    
    init(movieId: Int, useCase: MovieDetailUsecase) {
        self.movieId = movieId
        self.usecase = useCase
    }
    
    func fetchData() {
        guard movieId != nil || entity != nil else {
            return
        }
        guard !isFetched else { return }
        if let movieId = movieId {
            fetchMovieDetail(forId: movieId)
        } else if let entity = entity {
            fetchMovieDetail(forId: entity.id)
        }
    }
    
    func retry() {
        fetchData()
    }
    
    private func buildMovieDetail(for entity: Movie) {
        self.entity = entity
        isFetched = true
        let output = Output(title: entity.title,
                            releaseDate: entity.releaseDate,
                            rate: entity.voteAverage,
                            totalVote: "\(entity.voteCount)",
                            status: entity.status?.uppercased() ?? "Released".uppercased(),
                            adult: entity.isAdult ? "+18" : "No limitation",
                            backdropImage: getBackdropURL(entity),
                            overview: entity.overview,
                            popularity: "\(entity.popularity)")
        infos.accept(output)
    }
    
    private func fetchMovieDetail(forId id: Int) {
        guard !loading.value else { return }
        loading.accept(true)
        let movieRes = usecase.getMovieDetail(forId: id)
            .asObservable().share(replay: 1).mapToResult()
            .do(onCompleted: {[weak loading] in loading?.accept(false) })
        movieRes.compactMap(\.success).bind(with: self) { (self, movie) in
            self.buildMovieDetail(for: movie)
        }.disposed(by: disposeBag)
        movieRes.compactMap(\.failure).mapAt(\.localizedDescription).bind(to: errorSub).disposed(by: disposeBag)
    }
    
    private func getBackdropURL(_ model: Movie) -> URL? {
        guard let path = model.backdropPath else {
            return nil
        }
        return try? ImageUrlBuilder(baseURL: AppConfig.imageBaseURL)
            .imagePath(path)
            .imageType(.poster, width: 500)
            .build()
    }
    
}

extension MovieDetailsViewModel {
    
    struct Output {
        
        let title: String
        let releaseDate: String
        let rate: Double
        let totalVote: String
        let status: String
        let adult: String
        let backdropImage: URL?
        let overview: String
        let popularity: String
    }
    
}
