//
//  MovieListViewController.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MovieListViewController: BaseViewController<MovieListViewModel> {

    override class var storyboardName: String { "Movies" }
    
    override class var storyboardIdentifier: String { "MovieListVC" }
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
   
    lazy var dataSource: RxTableViewSectionedAnimatedDataSource<ViewModelType.SectionType> = {
        RxTableViewSectionedAnimatedDataSource {[unowned self] _, tableView, index, viewModel in
            let cell = tableView.dequeueReusableCell(type: MovieListTableCell.self, forIndexPath: index)
            cell.bind(to: viewModel)
            return cell
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchMovieListIfNeeded()
    }
    
    override func setupUILayouts() {
        tableView.separatorColor = .clear
        tableView.registerCell(type: MovieListTableCell.self)
        tableView.estimatedRowHeight = 250.0
        tableView.estimatedSectionHeaderHeight = 50.0
    }
    
    override func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.isLoading.asObservable().bind(to: loadingIndicatorView.rx.isAnimating,
                                                tableView.rx.isHidden).disposed(by: disposeBag)
        viewModel.items.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        viewModel.didErrorOccured.asObservable().bind(with: self) { (self, error) in
            self.presentAlertFor(error: error)
        }.disposed(by: disposeBag)
        tableView.rx.itemSelected.bind(with: viewModel) { viewModel, indexPath in
            viewModel.selectMovie(atIndex: indexPath.row)
        }.disposed(by: disposeBag)
        tableView.rx.willDisplayCell.bind(with: viewModel) { viewModel, cellEvent in
            viewModel.loadMoreMovies(afterIndex: cellEvent.indexPath.row)
        }.disposed(by: disposeBag)
    }
    
    private func presentAlertFor(error msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {[unowned self] _ in
            viewModel?.retryFetchMovie()
        }))
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            alert.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
