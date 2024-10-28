//
//  MovieSearchViewController.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources
import RxCocoa
import RxSwiftExt
import PureLayout

class MovieSearchViewController: BaseViewController<MovieSearchViewModel>, UISearchResultsUpdating {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    lazy var dataSource: RxTableViewSectionedAnimatedDataSource<ViewModelType.ResultSectionType> = {
        RxTableViewSectionedAnimatedDataSource {[unowned self] _, tableView, index, viewModel in
            let cell = tableView.dequeueReusableCell(type: MovieListTableCell.self, forIndexPath: index)
            cell.bind(to: viewModel)
            return cell
        }
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isKeyboardObserverEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isKeyboardObserverEnabled = false
    }
    
    override func setupUILayouts() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewSafeArea()
        tableView.registerCell(type: MovieListTableCell.self)
        tableView.separatorColor = .clear
        tableView.estimatedRowHeight = 250.0
    }
    
    override func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.results.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        viewModel.didErrorOccured.asObservable().bind(with: self) { (self, error) in
            self.presentAlertFor(error: error)
        }.disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell.bind(with: viewModel) { viewModel, cellEvent in
            viewModel.loadMoreResult(afterIndex: cellEvent.indexPath.row)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ViewModelType.ResultSectionType.Item.self)
            .catch { _ in .never() }.bind(to: viewModel.selectResult).disposed(by: disposeBag)
        viewModel.observeSearchTextChanges()
        viewModel.observeResultSelectChanges()
    }
    
    private func presentAlertFor(error msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {[unowned self] _ in
            // TODO: add retry mechanism
        }))
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            alert.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.searchText.onNext(searchController.searchBar.text ?? "")
    }
}
