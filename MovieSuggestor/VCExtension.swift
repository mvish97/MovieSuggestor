//
//  VCExtension.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/17/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

extension ViewController { // Tableview functions
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.performSegue(withIdentifier: "getMoreInfo", sender: genreArray[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MovieInfoVC {
            if let item = sender as? MovieModel {
                dest.movieInfo = item
            }
        }
    }
    
}

extension ViewController { // HELPER FUNCTIONS
    
    
    func getGenreList() -> [String] { // Used for testing
        // Separates the genre names from the Genre Objects
        var list: [String] = []
        
        for i in genres {
            list.append(i.name)
        }
        return list
    }
    
    func getGenreID(genre: String) -> Int {
        // Gets the id of the genre the user chose
        for i in genres {
            if i.name == genre {
                return i.id
            }
        }
        return 0
    }
    
    func filterForRatings() {
        // Functions filters the movies based the min rating the user chose
        genreArray = []
        
        for mov in movieArray {
            if mov.rating >= Double(selectedRating) {
                genreArray.append(mov)
            }
        }
    }
    
}
