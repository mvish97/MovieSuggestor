//
//  ViewController.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/15/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import UIKit
import TTADataPickerView

class ViewController: UIViewController, TTADataPickerViewDelegate {

    @IBOutlet weak var genreButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let pickerView = TTADataPickerView(title: "Genres", type: .text, delegate: nil)
    let genres = ["Action", "Adventure", "Comedy", "Thriller", "Rom Com", "Romantic", "Horror"]
    
    var movieArray: [MovieModel] = []
    var genreArray: [MovieModel] = []
    var selectedGenre: String = ""
    
    var mainColor = UIColor(red: 66/255, green: 148/255, blue: 247/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        populateMovies()
        
    }

    @IBAction func selectGenre(_ sender: UIButton) {
        pickerView.type = .text
        
        pickerView.delegate = self
        
        pickerView.textItemsForComponent = [genres]
        
        let titles = [String]() // Array that stores the selected times
        
        pickerView.selectedTitles(titles)
        
        pickerView.setTitleColor(color: mainColor)
        pickerView.setTitleFont(font: UIFont(name: "Avenir", size: 18)!)
        pickerView.setToolBarTintColor(color: mainColor)
        pickerView.setToolBarBarTintColor(color: UIColor.black)
        pickerView.backgroundColor = mainColor
        
        pickerView.show()
    }
    
    @IBAction func selectRating(_ sender: UISlider) {
        ratingLabel.text =  "\(Int(sender.value))"
    }

    func dataPickerView(_ pickerView: TTADataPickerView, didSelectTitles titles: [String]) {
        genreButton.setTitle(titles[0], for: .normal)
        selectedGenre = titles[0]
    }
    
    @IBAction func findMoviesPressed(_ sender: UIButton) {
        
        processGenre()
        
        tableView.reloadData()
    }
    
    func populateMovies() {
        movieArray = [MovieModel(poster: #imageLiteral(resourceName: "wonder woman"), name: "Wonder Woman", duration: "2 hr 21 min", rating: 7.7, genre: "Action"),
                      MovieModel(poster: #imageLiteral(resourceName: "the big sick"), name: "The Big Sick", duration: "2 hr", rating: 8.0, genre: "Rom Com"),
                      MovieModel(poster: #imageLiteral(resourceName: "guardians 2"), name: "Guardians of the Galaxy Vol. 2", duration: "2 hr 16 min", rating: 7.9, genre: "Adventure")]
    }
    
    func processGenre() {
        genreArray = []
        
        for i in movieArray {
            if i.genre == selectedGenre {
                genreArray.append(i)
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell {
            cell.updateUI(movie: genreArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
}

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func updateUI(movie: MovieModel) {
        posterImage.image = movie.poster
        nameLabel.text = movie.name
        durationLabel.text = movie.duration
        ratingLabel.text = "\(movie.rating)/10"
    }
    
    
}
