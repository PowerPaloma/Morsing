//
//  UIView+Shadow.swift
//  Morsing
//
//  Created by Paloma Bispo on 14/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//


import UIKit


extension UIView {
    
    func addShadow(scale: Bool = true) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
    }
}




