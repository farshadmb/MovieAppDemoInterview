//
//  MovieListViewController.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import UIKit

class MovieListViewController: BaseViewController<MovieListViewModel> {

    override class var storyboardName: String { "Movies" }
    
    override class var storyboardIdentifier: String { "MovieListVC" }
    
    override func setupUILayouts() {
        view.backgroundColor = .systemRed
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
