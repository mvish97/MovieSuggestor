//
//  MovieDB.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/16/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

protocol TransferData {
    func transferData(data: [GenreModel])
}

protocol TransferMovies {
    func transferMovies(data: [MovieModel])
}

class MovieDB {
    
    let BASE_URL = "https://api.themoviedb.org/3"
    let API_KEY = "api_key=5c6fa16f68f757d257aae5fc752765c6"
    
    let GENRE_LIST = "/genre/movie/list?"
    
    let LANG = "&language=en-US"
    
    let IMAGE_URL = "https://image.tmdb.org/t/p/w500/"
    
    var delegate: TransferData? = nil
    var movieDelegate: TransferMovies? = nil
    
    var genreList: [GenreModel] = []
    var movieList: [MovieModel] = []
    
    func getGenreList() {
        
        
        let url = BASE_URL + GENRE_LIST + API_KEY + LANG
        
        Alamofire.request(url).responseJSON { response in
            if let result = response.result.value as? Dictionary<String,Any> {
                if let list = result["genres"] as? [Dictionary<String,Any>] {
                    for dict in list {
                        let temp_id = dict["id"] as! Int!
                        let temp_name = dict["name"] as! String!
                        
                        self.genreList.append(GenreModel(name: temp_name! , id: temp_id!))
                    }
                    
                    if let del = self.delegate {
                        del.transferData(data: self.genreList)
                    }
                }
            }
        }
    }
    
    func getMovieList(genreID: Int, page: Int) {
        
        let url = BASE_URL + "/discover/movie?" + API_KEY + LANG + "&sort_by=popularity.desc&include_adult=true&page=\(page)&with_genres=\(genreID)"
        
        self.movieList = []
        Alamofire.request(url).responseJSON { response in
            if let result = response.result.value as? Dictionary<String,Any> {
                if let list = result["results"] as? [Dictionary<String,Any>] {
                    for i in list {
                        //print(i["title"]!, i["vote_average"]!)
                        
                        self.movieList.append(MovieModel(poster: #imageLiteral(resourceName: "wonder woman"), name: i["title"] as! String, overview: i["overview"] as! String, rating: i["vote_average"] as! Double, year: i["release_date"] as! String))
                        
                        //self.getMoviePoster(url: "\(self.IMAGE_URL)\(i["poster_path"]!)")
                        
                    }
                    
                    if let del = self.movieDelegate {
                        del.transferMovies(data: self.movieList)
                    }
                   
                }
            }
        }
    }
    
    
    func getMoviePoster(url: String) {
        Alamofire.request(url).responseJSON { response in
            //print(response.result.value)
        }
    }
}
