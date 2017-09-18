//
//  MovieInfoVC.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/17/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class MovieInfoVC: UIViewController {
    
    @IBOutlet weak var movieBackground: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movieInfo: MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        
        let url = URL(string: movieInfo.backgrounLink)
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url!)
                DispatchQueue.global().sync {
                    self.movieBackground.image = UIImage(data: data)!
                }
            }
            catch  {
                //handle the error
            }
        }
        
        movieTitle.text = movieInfo.name
        yearLabel.text = getYear(date: movieInfo.year)
        ratingLabel.text = "\(movieInfo.rating) / 10"
        overviewLabel.text = movieInfo.overview
    }
    
}
