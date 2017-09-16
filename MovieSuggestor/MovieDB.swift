//
//  MovieDB.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/16/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import Alamofire

class MovieDB {
    
    let BASE_URL = "https://api.themoviedb.org/3"
    let API_KEY = "api_key=5c6fa16f68f757d257aae5fc752765c6"
    
    let GENRE_LIST = "/genre/movie/list?"
    
    let LANG = "&language=en-US"
    
    let IMAGE_URL = "https://image.tmdb.org/t/p/w500/"
    
    func getGenreList() -> [GenreModel] {
        var genreList: [GenreModel] = []
        
        let url = BASE_URL + GENRE_LIST + API_KEY + LANG
        
        Alamofire.request(url).responseJSON { response in
            if let result = response.result.value as? Dictionary<String,Any> {
                if let list = result["genres"] as? [Dictionary<String,Any>] {
                    for dict in list {
                        let temp_id = dict["id"] as! Int!
                        let temp_name = dict["name"] as! String!
                        genreList.append(GenreModel(name: temp_name! , id: temp_id!))
                    }
                }
            }
        }
        print(genreList)
        return genreList
    }
}
