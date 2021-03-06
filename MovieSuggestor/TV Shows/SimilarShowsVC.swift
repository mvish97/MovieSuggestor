//
//  SimilarShowsVC.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/30/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class SimilarShowsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var similarToLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var showList: [MovieModel] = []
    var originalShowName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        similarToLabel.text = "Shows similar to \(originalShowName)"
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "similarShowCell", for: indexPath) as? SimilarShowCell {
            cell.updateUI(show: showList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "similarShowsInfo", sender: showList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? TVShowInfoVC {
            if let item = sender as? MovieModel {
                dest.showInfo = item
            }
        }
    }
}

class SimilarShowCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    func updateUI(show: MovieModel) {
        posterImage.image = show.poster
        nameLabel.text = "\(show.name) (\(getYear(date: show.year)))"
        ratingLabel.text = "\(show.rating) / 10"
        genresLabel.text = getGenreNames(ids: show.genres)
    }
    
}
