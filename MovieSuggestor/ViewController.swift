//
//  ViewController.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/15/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import UIKit
import TTADataPickerView

var mainColor = UIColor(red: 66/255, green: 148/255, blue: 247/255, alpha: 1.0)

class ViewController: UIViewController, TTADataPickerViewDelegate, TransferData, TransferMovies, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var genreButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var getSuggestions: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    
    let pickerView = TTADataPickerView(title: "Genres", type: .text, delegate: nil)
    var genres = [GenreModel]() // List of Genres and their ids
    var genreNames: [String] = [] // List used to populate the pickerview
    
    var movieArray: [MovieModel] = [] // Gets all the movies for that genre
    var genreArray: [MovieModel] = [] // Has the filtered movies from that genre
    
    
    let backend = MovieDB()
    
    
    var selectedGenre: String = ""
    var selectedRating: Int = 5
    var selectedPage: Int = 1
    var moreOrPrevPressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        buttonsetup()
        
        backend.delegate = self
        backend.getGenreList()
        backend.movieDelegate = self
    }
    
    func transferData(data: [GenreModel]) { // Getting the genre list
        genres = data
        genreNames = getGenreList()
    }
    
    func transferMovies(data: [MovieModel]) { // Getting the movie list
        //movieArray = []
        movieArray = data
        filterForRatings() // FILTER in case the user doesn't change the default rating
        
        if moreOrPrevPressed {
            tableView.reloadData()
        }
    }
    
    func processMovieArray() -> [String] { // for testing
        
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
        if selectedGenre != titles[0] {
            genreButton.setTitle(titles[0], for: .normal)
            selectedGenre = titles[0] // The genre the user selected
            
            // New genre selected so starting from page 1
            moreOrPrevPressed = false
            selectedPage = 1
            getSuggestions.setTitle("Get", for: .normal)
            self.backend.getMovieList(genreID: getGenreID(genre: selectedGenre), page: selectedPage)
        }
    }
    
    @IBAction func findMoviesPressed(_ sender: UIButton) {
        
        if getSuggestions.titleLabel?.text == "Get" {
            getSuggestions.setTitle("Filter", for: .normal)
        }
        tableView.reloadData()
    }
    
    @IBAction func moreMoviesPressed(_ sender: UIButton) {
        moreOrPrevPressed = true
        selectedPage += 1
        self.backend.getMovieList(genreID: getGenreID(genre: selectedGenre), page: selectedPage)
    }
    
    @IBAction func prevMoviesPressed(_ sender: UIButton) {
        if selectedPage-1 != 0 {
            moreOrPrevPressed = true
            selectedPage -= 1
            self.backend.getMovieList(genreID: getGenreID(genre: selectedGenre), page: selectedPage)
        }
    }
    
    func buttonsetup() {
        getButton.layer.cornerRadius = 10
        prevButton.layer.cornerRadius = 10
        moreButton.layer.cornerRadius = 10
    }
}

func getYear(date: String) -> String {
    let index = date.index(date.startIndex, offsetBy: 4)
    return date.substring(to: index)
}


class MovieCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func updateUI(movie: MovieModel) {
        
        posterImage.image = movie.poster
        nameLabel.text = movie.name
        durationLabel.text = getYear(date: movie.year)
        ratingLabel.text = "\(movie.rating) / 10"
    }
}
