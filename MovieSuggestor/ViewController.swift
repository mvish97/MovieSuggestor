//
//  ViewController.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/15/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import UIKit
import TTADataPickerView

class ViewController: UIViewController, TTADataPickerViewDelegate, TransferData, TransferMovies {

    @IBOutlet weak var genreButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let pickerView = TTADataPickerView(title: "Genres", type: .text, delegate: nil)
    var genres = [GenreModel]() // List of Genres and their ids
    var genreNames: [String] = []
    
    var movieArray: [MovieModel] = []
    var genreArray: [MovieModel] = [] // The list that will used to populate the tableview
    
    
    let backend = MovieDB()
    
    
    var selectedGenre: String = ""
    var selectedRating: Int = 5
    
    var mainColor = UIColor(red: 66/255, green: 148/255, blue: 247/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        backend.delegate = self
        backend.getGenreList()
        
        backend.movieDelegate = self
    }
    
    func transferData(data: [GenreModel]) { // Getting the genre list
        genres = data
        genreNames = getGenreList()
    }
    
    func transferMovies(data: [MovieModel]) { // Getting the movie list
        movieArray = []
        movieArray = data
        
        filterForRatings() // FILTER
    }
    
    func processMovieArray() -> [String] {
        
        var list: [String] = []
        
        for i in genreArray {
            list.append(i.name)
        }
        
        return list
    }

    @IBAction func selectGenre(_ sender: UIButton) {
        pickerView.type = .text
        pickerView.delegate = self
        pickerView.textItemsForComponent = [genreNames]
        
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
        
        selectedRating = Int(sender.value) // The rating the user selected
        ratingLabel.text =  "\(selectedRating)"
        
        filterForRatings() // FILTER
    }

    func dataPickerView(_ pickerView: TTADataPickerView, didSelectTitles titles: [String]) {
        genreButton.setTitle(titles[0], for: .normal)
        selectedGenre = titles[0] // The genre the user selected
        
        self.backend.getMovieList(genreID: getGenreID(genre: selectedGenre))
    }
    
    @IBAction func findMoviesPressed(_ sender: UIButton) {
        
        tableView.reloadData()
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

extension ViewController { // HELPER FUNCTIONS
    
    
    func getGenreList() -> [String] {
        // Separates the genre names from the Genre Objects
        var list: [String] = []
        
        for i in genres {
            list.append(i.name)
        }
        return list
    }
    
    func getGenreID(genre: String) -> Int {
        
        for i in genres {
            if i.name == genre {
                return i.id
            }
        }
        return 0
    }
    
    func filterForRatings() {
        
        genreArray = []
        
        for mov in movieArray {
            if mov.rating >= Double(selectedRating) {
                genreArray.append(mov)
            }
        }
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
        durationLabel.text = movie.year
        ratingLabel.text = "\(movie.rating) / 10"
    }
    
    
}
