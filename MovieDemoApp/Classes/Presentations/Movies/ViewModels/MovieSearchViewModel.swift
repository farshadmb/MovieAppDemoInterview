//
//  MovieSearchViewModel.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import RxDataSources

final class MovieSearchViewModel {
    
    typealias ResultSectionType = AnimatableSectionModel<Int, MovieListItemViewModel>
    
    // MARK: - Inputs
    let searchText = PublishSubject<String>()
    let selectResult = PublishSubject<ResultSectionType.Item>()
    
    // MARK: - outputs
    
    var isLoading: Driver<Bool> { loading.asDriver() }
    var results: Driver<[ResultSectionType]> {
        searchResult.asDriver()
            .map { [ResultSectionType(model: 0, items: $0)] }
    }
    
    var didErrorOccured: Driver<String> { error.asDriver(onErrorDriveWith: .never()) }
    
    let usecase: MovieListUsecase
    
    let disposeBag = DisposeBag()
    
    private let searchResult = BehaviorRelay<[ResultSectionType.Item]>(value: [])
    private let queryText = BehaviorRelay(value: "")
    private let loading = BehaviorRelay(value: false)
    private let error = PublishRelay<String>()
    private var page = 0
    
    init(usecase: MovieListUsecase) {
        self.usecase = usecase
        disposeBag.insert(searchText)
        disposeBag.insert(selectResult)
    }
    
    func observeSearchTextChanges() {
        searchText.distinctUntilChanged().asDriver(onErrorJustReturn: "").asObservable()
            .bind(to: queryText).disposed(by: disposeBag)
        searchText.distinctUntilChanged().asDriver(onErrorJustReturn: "")
            .debounce(.milliseconds(500)).asObservable().bind(with: self) { (self, queryText) in
                self.searchMovie(for: queryText)
            }.disposed(by: disposeBag)
    }
    
    func observeResultSelectChanges() {
        selectResult.debounce(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .bind(with: self) { (_, _) in
                // TODO: add select and navigation
            }.disposed(by: disposeBag)
    }
   
    func loadMoreResult(afterIndex index: Int) {
        guard index + 1 >= searchResult.value.count else {
            return
        }
        loadMoreResult()
    }
    
    // MARK: - Private Methods
    
    private func searchMovie(for text: String) {
        guard text.isEmptyOrBlank == false else {
            clearResults()
            return
        }
        search(text: text, page: 1, clearResults: true)
    }
    
    private func loadMoreResult() {
        guard !loading.value else { return }
        let text = queryText.value
        search(text: text, page: page + 1)
    }
    
    private func search(text: String, page: Int, clearResults: Bool = false) {
        loading.accept(true)
        let source = usecase.searchMovies(key: text, page: page, size: 0)
            .asObservable().share(replay: 1)
            .mapToResult()
            .do(onCompleted: { [weak loading] in loading?.accept(false) })
        
        source.compactMap(\.success).bind(with: self) { (self, movies) in
            self.page = page
            let result: [ResultSectionType.Item]
            if !clearResults {
                var newItems = [ResultSectionType.Item]()
                for vModel in self.searchResult.value + movies.map(MovieListItemViewModel.init) {
                    newItems.append(unique: vModel)
                }
                result = newItems
            } else {
                result = movies.map(MovieListItemViewModel.init)
            }
            self.searchResult.accept(result)
        }.disposed(by: disposeBag)
        
        source.compactMap(\.failure).bind(with: self) { (self, error) in
            print("💥 error:", error)
            self.error.accept(error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    private func clearResults() {
        searchResult.accept([])
    }
}
