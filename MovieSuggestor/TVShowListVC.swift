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
    @IBOutlet weak var naviBar: UINavigationBar!
    
    var naviTitle = String()
    var tv_backend = MovieDB()
    var tv_list: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviBar.topItem?.title = naviTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tv_backend.showDelegate = self
        tv_backend.getShowList(type: getShowType())
    }
    
    @IBAction func pressedDone(_ sender: UIBarButtonItem) {
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
}

func getGenreNames(ids: [Int]) -> [String] { // GLOBAL
    
    var names = [String]()
    
    for i in ids {
        for j in genres {
            if j.id == i {
                names.append(j.name)
            }
        }
    }
    return names
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
        
        var genreText = ""
        let genreNames = getGenreNames(ids: show.genres)
        
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
    }
    
}
