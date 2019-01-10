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
        let deviceScale = UIScreen.main.scale
        
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y: 1);
        gradient.colors = colors
        
        
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.size.width * deviceScale, height: self.frame.size.height * deviceScale)

        self.layer.insertSublayer(gradient, at: 0)
    }
}
