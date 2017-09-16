//
//  MovieModel.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/15/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class MovieModel {
    
    private var _poster: UIImage!
    private var _name: String!
    private var _duration: String!
    private var _rating: Double!
    private var _genre: String!
    
    var poster: UIImage {
        return _poster
    }
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var duration: String {
        if _duration == nil {
            _duration = ""
        }
        return _duration
    }
    
    var rating: Double {
        if _rating == nil {
            _rating = 0.0
        }
        return _rating
    }
    
    var genre: String {
        if _genre == nil {
            _genre = ""
        }
        return _genre
    }
    
    init(poster: UIImage, name: String, duration: String, rating: Double, genre: String) {
        _poster = poster
        _name = name
        _duration = duration
        _rating = rating
        _genre = genre
    }
}
