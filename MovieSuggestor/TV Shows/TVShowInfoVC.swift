//
//  TVShowInfoVC.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/29/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class TVShowInfoVC: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    var showInfo: MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        posterImage.image = showInfo.background
        nameLabel.text = showInfo.name
        yearLabel.text = getYear(date: showInfo.year)
        ratingLabel.text = "\(showInfo.rating) / 10"
        
        var genreText = ""
        let genreNames = getGenreNames(ids: showInfo.genres)
        
        if genreNames.count > 2 {
            for i in 0...genreNames.count-1 {
                if i != genreNames.count-1 {
                    genreText += "\(genreNames[i]), "
                }
                else {
                    genreText += "& \(genreNames[i])"
                }
            }
            
            genreLabel.text = genreText
        }
        else if genreNames.count == 2 {
            genreLabel.text = genreNames[0] + " & " + genreNames[1]
        }
        else {
            genreLabel.text = genreNames[0]
        }

        overviewLabel.text = showInfo.overview
    }
}

