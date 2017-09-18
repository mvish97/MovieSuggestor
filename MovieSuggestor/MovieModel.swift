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
    private var _name: String! // original_title
    private var _overview: String! // overview
    private var _rating: Double! // vote_average
    private var _year: String!
    private var _posterLink: String!
    private var _backgroundLink: String!
    
    var poster: UIImage {
        return _poster
    }
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var overview: String {
        if _overview == nil {
            _overview = ""
        }
        return _overview
    }
    
    var rating: Double {
        if _rating == nil {
            _rating = 0.0
        }
        return _rating
    }
    
    var year: String {
        if _year == nil {
            _year = ""
        }
        return _year
    }
    
    var posterLink: String {
        if _posterLink == nil {
            _posterLink = ""
        }
        return _posterLink
    }
    
    var backgrounLink: String {
        if _backgroundLink == nil {
            _backgroundLink = ""
        }
        return _backgroundLink
    }
    
    init(poster: UIImage, name: String, overview: String, rating: Double, year: String, posterLink: String, backLink: String) {
        _poster = poster
        _name = name
        _overview = overview
        _rating = rating
        _year = year
        _posterLink = posterLink
        _backgroundLink = backLink
    }
}

class GenreModel {
    
    private var _name: String!
    private var _id: Int!
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var id: Int {
        if _id == nil {
            _id = 0
        }
        return _id
    }
    
    init(name: String, id: Int) {
        _name = name
        _id = id
    }
}

