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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = ""
        rateLabel.text = ""
        releaseDate.text = ""
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        releaseDate.text = viewModel.releaseDate
        rateLabel.text = viewModel.rating
    }
}
