//
//  TVShowInfoVC.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/29/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class TVShowInfoVC: UIViewController, TransferSimilarShows {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var backend = MovieDB()
    
    var showInfo: MovieModel!
    
    var similarShowsList: [MovieModel] = []
    
    var segueObject: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        backend.getSimilarShows(id: showInfo.id)
        backend.similarShowDelegate = self
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func similarShowsPressed(_ sender: UIButton) {
        segueObject["Showlist"] = similarShowsList
        segueObject["CurrentShow"] = showInfo.name
        performSegue(withIdentifier: "similarShows", sender: segueObject)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SimilarShowsVC {
            if let item = sender as? Dictionary<String,Any> {
                dest.showList = item["Showlist"] as! [MovieModel]
                dest.originalShowName = item["CurrentShow"] as! String
            }
        }
    }
    
    func transferSimilarShows(data: [MovieModel]) {
        similarShowsList = data
    }
    
    
    func updateUI() {
        posterImage.image = showInfo.background
        nameLabel.text = showInfo.name
        yearLabel.text = getYear(date: showInfo.year)
        ratingLabel.text = "\(showInfo.rating) / 10"
        
        genreLabel.text = getGenreNames(ids: showInfo.genres)
    
        overviewTextView.text = showInfo.overview
        overviewTextView.isEditable = false
    }
}

