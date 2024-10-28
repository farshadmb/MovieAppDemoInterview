//
//  RxSwift+Additionals.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import RxSwift

extension ObservableType {
    
    func mapToResult() -> Observable<Result<Element, Error>> {
        return map { Result.success($0) }.catch { .just(Result.failure($0)) }
    }
    
    func mapToResult<T>(transform: @escaping (Element) throws -> T) -> Observable<Result<T, Error>> {
        return map { value in Result { try transform(value) } }.catch { .just(Result.failure($0)) }
    }
}

extension ObservableType where Element: Collection {

    /**
     Projects each element of an observable collection into a new form.

     - parameter transform: A transform function to apply to each element of the source collection.
     */
    func compactMapMany<Result>(_ transform: @escaping (Element.Element) throws -> Result?) -> Observable<[Result]> {
        return map { collection -> [Result] in
            try collection.compactMap(transform)
        }
    }
}

