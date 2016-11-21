//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Downey, Eric on 11/20/16.
//  Copyright © 2016 Eric Downey. All rights reserved.
//

import UIKit
import Alamofire

protocol SelectedMovie {
    var movie: Movie? { get set }
}

class MovieDetailViewController: UIViewController, SelectedMovie {
    
    @IBOutlet var movieTitleLabel: UILabel?
    @IBOutlet var movieYearLabel: UILabel?
    @IBOutlet var moviePosterImageView: UIImageView?
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleLabel?.text = movie?.title
        movieYearLabel?.text = movie?.year
        
        if let url = movie?.posterUrl {
            Alamofire.request(url).response(completionHandler: imageCompletion)
        }
    }
    
    private func imageCompletion(with response: DefaultDataResponse?) {
        if let data = response?.data {
            moviePosterImageView?.image = UIImage(data: data)
        }
    }
}
