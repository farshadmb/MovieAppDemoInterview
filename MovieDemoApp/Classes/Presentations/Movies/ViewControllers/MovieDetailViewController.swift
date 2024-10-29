//
//  MovieDetailViewController.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import PureLayout

class MovieDetailViewController: BaseViewController<MovieDetailsViewModel> {

    override class var storyboardName: String { "Movies" }
    
    override class var storyboardIdentifier: String { "MovieDetailVC" }
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ratingView: CircularRateView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var totalVoteLabel: UILabel!
    
    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var seperatorsView: [UIView]!
    
    @IBOutlet weak var scrollView: UIScrollView!
   
    private var scrollViewContentView: UIView! {
        return scrollView.subviews.first
    }
    
    private var overviewSectionView: UIView? {
        return overviewLabel.superview?.superview
    }
    
    private var loadingIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie Details"
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
    }
    
    override func setupUILayouts() {
        for label in titleLabels {
            label.font = .preferredFont(forTextStyle: .subheadline)
            label.textColor = .Styles.tertiary
        }
        
        for label in [overviewLabel, popularityLabel, adultLabel, totalVoteLabel] {
            label?.textColor = .Styles.secondary
        }
        
        titleLabel.textColor = .Styles.primary
        releaseDateLabel.textColor = .Styles.tertiary
        statusLabel.textColor = .Styles.tertiary
        
        ratingView.lineColor = [UIColor.Styles.green, UIColor.Styles.blue,
                                UIColor.Styles.yellow, UIColor.Styles.red].randomElement() ?? .Styles.green
        ratingView.backgroundColor = .Styles.defaultBackground
        loadingIndicatorView.hidesWhenStopped = true
        loadingIndicatorView.color = .systemBlue
        view.addSubview(loadingIndicatorView)
        loadingIndicatorView.autoCenterInSuperview()
        
        overviewSectionView?.backgroundColor = .Styles.primaryGroupedBackground
        
        scrollView.backgroundColor = .Styles.defaultBackground
        scrollViewContentView.backgroundColor = .Styles.defaultBackground
        
        for (index, view) in seperatorsView.enumerated() {
            view.backgroundColor = .Styles.separator
            view.isHidden = index == (seperatorsView.count - 1)
            view.layer.cornerRadius = view.bounds.height / 2
            view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner,
                                        .layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchData()
    }
    
    override func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.isLoading.asObservable().bind(to: loadingIndicatorView.rx.isAnimating,
                                                scrollView.rx.isHidden).disposed(by: disposeBag)
        viewModel.error.asObservable().bind(with: self) { (self, errorMessage) in
            self.presentAlertFor(error: errorMessage) {[weak self] in
                self?.viewModel?.retry()
            }
        }.disposed(by: disposeBag)
        viewModel.output.asObservable().bind(with: self) { (self, output) in
            self.titleLabel.text = output.title
            self.releaseDateLabel.text = output.releaseDate
            self.statusLabel.text = output.status
            self.backdropImageView.setImage(url: output.backdropImage, placeHolderImage: .imagePlaceholder)
            self.overviewLabel.text = output.overview
            self.adultLabel.text = output.adult
            self.totalVoteLabel.text = output.totalVote
            self.popularityLabel.text = output.popularity
            self.ratingView.rate = output.rate
        }.disposed(by: disposeBag)
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
