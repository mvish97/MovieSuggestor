//
//  MaterialView.swift
//  TourUpApp
//
//  Created by Vatsal Rustagi on 7/10/17.
//  Copyright © 2017 TourUp. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView {
    
    @IBInspectable var materialDesign: Bool{
        get{
            return materialKey
        }
        set{
            materialKey = newValue
            
            if materialKey{
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 0.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 2.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                self.layer.shadowColor = UIColor(red: 66/255, green: 148/255, blue: 247/255, alpha: 1.0).cgColor
            }
            else{
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
    }
}
