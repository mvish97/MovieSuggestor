//
//  MovieInfoVC.swift
//  MovieSuggestor
//
//  Created by Vishnu on 9/17/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation
import UIKit

class MovieInfoVC: UIViewController {
    
    @IBOutlet weak var movieBackground: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movieInfo: MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
    
        movieBackground.image = movieInfo.background
        movieTitle.text = movieInfo.name
        yearLabel.text = getYear(date: movieInfo.year)
        ratingLabel.text = "\(movieInfo.rating) / 10"
        overviewLabel.text = movieInfo.overview
    }
    
    @IBDesignable class TopAlignedLabel: UILabel {
        override func drawText(in rect: CGRect) {
            if let stringText = text {
                let stringTextAsNSString = stringText as NSString
                let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width,height: CGFloat.greatestFiniteMagnitude),
                                                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                        attributes: [NSFontAttributeName: font],
                                                                        context: nil).size
                super.drawText(in: CGRect(x:0,y: 0,width: self.frame.width, height:ceil(labelStringSize.height)))
            } else {
                super.drawText(in: rect)
            }
        }
        override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            layer.borderWidth = 1
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
}
