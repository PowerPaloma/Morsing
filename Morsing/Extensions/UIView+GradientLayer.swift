//
//  UIView+GradientLayer.swift
//  Morsing
//
//  Created by Levy Cristian  on 10/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//
import UIKit

extension UIView {
    
    func setGradientToView(colors: [CGColor]){
        let gradient = CAGradientLayer()
        
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y: 1);
        gradient.colors = colors
        gradient.frame = self.bounds

        self.layer.insertSublayer(gradient, at: 0)
    }
}
