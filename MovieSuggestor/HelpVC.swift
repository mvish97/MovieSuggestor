//
//  HelpVC.swift
//  MovieSuggestor
//
//  Created by Vishnu on 3/12/18.
//  Copyright © 2018 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class HelpVC: ViewController {
    
    @IBOutlet weak var showsButton: UIButton!
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        
    }
    
    @IBAction func showsHelpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showsHelp", sender: nil)
    }
    
    @IBAction func moviesHelpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "moviesHelp", sender: nil)
    }
}

class MoviesHelpVC: UIViewController {
    
    override func viewDidLoad() {
        //super.viewDidLoad()
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

class ShowsHelpVC: UIViewController {
    
    override func viewDidLoad() {
        //super.viewDidLoad()
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
