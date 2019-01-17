//
//  UIView+GradientLayer.swift
//  Morsing
//
//  Created by Levy Cristian  on 10/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//
import UIKit

enum AppGradientsVariantions {
    case Default
}

extension AppGradientsVariantions: RawRepresentable {
    typealias RawValue = [CGColor]
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case [UIColor(red:0.11, green:0.90, blue:0.89, alpha:1.0).cgColor, UIColor(red:0.71, green:0.53, blue:0.97, alpha:1.0).cgColor]: self = .Default
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .Default: return [UIColor(red:0.11, green:0.90, blue:0.89, alpha:1.0).cgColor, UIColor(red:0.71, green:0.53, blue:0.97, alpha:1.0).cgColor]
        }
    }
}

extension UIView {
    
    func setGradientToView(opition: AppGradientsVariantions){
        let gradient = CAGradientLayer()
        
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y: 1);
        gradient.colors = opition.rawValue
        gradient.frame = self.bounds

        self.layer.insertSublayer(gradient, at: 0)
    }
}
