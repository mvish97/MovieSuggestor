//
//  TVShowListVC.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/25/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class TVShowListVC: UIViewController, TranferShows, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var naviTitle = String()
    var tv_backend = MovieDB()
    var tv_list: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = naviTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tv_backend.showDelegate = self
        tv_backend.getShowList(type: getShowType())
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func getShowType() -> String {
        if naviTitle == "Popular Shows" {
            return "popular"
        }
        else {
            return "top_rated"
        }
    }
    
    func transferShows(data: [MovieModel]) { // Delegate method that populates the table view
        tv_list = data
        
        sleep(1)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? TVShowCell {
            cell.updateUI(show: tv_list[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tv_list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showInfo", sender: tv_list[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? TVShowInfoVC {
            if let item = sender as? MovieModel {
                dest.showInfo = item
            }
        }
    }
}

func getGenreNames(ids: [Int]) -> String { // GLOBAL
    
    var names = [String]()
    
    for i in ids {
        for j in genres {
            if j.id == i {
                names.append(j.name)
            }
        }
    }
    
    var genreText: String = ""
    
    if names.count > 2 {
        for i in 0...names.count-1 {
            if i != names.count-1 {
                genreText += "\(names[i]), "
            }
            else {
                genreText += "& \(names[i])"
            }
        }
        
        return genreText
    }
    else if names.count == 2 {
        return names[0] + " & " + names[1]
    }
    else if names.count == 1 {
        return names[0]
    }
    else { return "" }
}



class TVShowCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    
    func updateUI(show: MovieModel) {
        posterImage.image = show.poster
        nameLabel.text = "\(show.name) (\(getYear(date: show.year)))"
        ratingLabel.text = "\(show.rating) / 10"
        genreLabel.text = getGenreNames(ids: show.genres)
    }
    
}
