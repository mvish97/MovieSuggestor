//
//  TVShowVC.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/25/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class TVShowVC: ViewController {
    
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var topRatedButton: UIButton!
    
    let tv_backend = MovieDB()
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        
        popularButton.layer.cornerRadius = 10.0
        topRatedButton.layer.cornerRadius = 10.0
    }
    
    @IBAction func popularPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "tvList", sender: "Popular Shows")
    }
    
    @IBAction func topRatedPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "tvList", sender: "Top Rated Shows")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? TVShowListVC {
            if let item = sender as? String {
                dest.naviTitle = item
            }
        }
    }
    
    
}
