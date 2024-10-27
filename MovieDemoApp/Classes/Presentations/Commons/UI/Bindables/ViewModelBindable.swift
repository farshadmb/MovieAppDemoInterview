//
//  ViewModelBindable.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation
import UIKit

protocol ViewModelBindableType: AnyObject, NSObjectProtocol {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType? { get set }
    
    func bindViewModel()
    
}

extension ViewModelBindableType where Self: UIViewController {
    
    func bind(to viewModel: ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension ViewModelBindableType where Self: UIView {

    func bind(to viewModel: ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}

extension ViewModelBindableType where Self: UITableViewCell {

    func bind(to viewModel: ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}

extension ViewModelBindableType where Self: UICollectionViewCell {

    func bind(to viewModel: ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
