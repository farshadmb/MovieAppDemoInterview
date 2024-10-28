//
//  RemoteMoviesRepository.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import RxSwift
import RxSwiftExt

final class RemoteMoviesRepository: MoviesRepository {
    
    typealias MoviesResponse = GenericResponse<MovieListResponse>
    
    let apiClient: ApiClient
    let baseURL: URL
    
    init(apiClient: ApiClient, baseURL: URL) {
        self.apiClient = apiClient
        self.baseURL = baseURL
    }
    
    func movieList(page: Int, size: Int) -> Single<[Movie]> {
        Observable.create {[weak base = self] observer in
            guard let self = base else {
                return Disposables.create()
            }
            do {
                let request = try MoviesRequestEndpoint.movieList(page: page).request(baseURL: self.baseURL)
                let task = try self.apiClient
                    .sendRequest(request: request) { (response: Result<MoviesResponse, Error>) in
                        switch response {
                        case .success(let result):
                            observer.onNext(result.data?.results.map { $0.toDomain() } ?? [])
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
                return Disposables.create {
                    task.cancel()
                }
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
        .asSingle()
    }
    
    func searchMovieList(key: String, page: Int, size: Int) -> Single<[Movie]> {
        Observable.create {[weak base = self] observer in
            guard let self = base else {
                return Disposables.create()
            }
            do {
                let request = try MoviesRequestEndpoint.searchMovie(query: key, page: page)
                    .request(baseURL: self.baseURL)
                let task = try self.apiClient
                    .sendRequest(request: request) { (response: Result<MoviesResponse, Error>) in
                        switch response {
                        case .success(let result):
                            observer.onNext(result.data?.results.map { $0.toDomain() } ?? [])
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
                
                return Disposables.create {
                    task.cancel()
                }
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
        .asSingle()
    }
    
}
