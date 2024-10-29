//
//  MovieListTableCell.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import UIKit

class MovieListTableCell: UITableViewCell, ViewModelBindableType {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var startImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    var viewModel: MovieListItemViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        rateLabel.text = nil
        releaseDate.text = nil
        movieImageView.cancelCurrentImageLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = ""
        rateLabel.text = ""
        releaseDate.text = ""
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = movieImageView.bounds.width / 8
        titleLabel.textColor = .Styles.primary
        releaseDate.textColor = .Styles.tertiary
        rateLabel.textColor = .Styles.secondary
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        movieImageView.superview?.backgroundColor = .Styles.defaultBackground
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        releaseDate.text = viewModel.releaseDate
        rateLabel.text = viewModel.rating
        movieImageView.setImage(url: viewModel.getPosterURL(),
                                placeHolderImage: .imagePlaceholder,
                                contentMode: .scaleAspectFit)
    }
}
