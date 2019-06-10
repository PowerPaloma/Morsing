//
//  UIColor+Morsing.swift
//  Morsing
//
//  Created by Levy Cristian  on 12/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

struct Color {
    static let backgoundGray = UIColor(red:0.93, green:0.95, blue:0.96, alpha:1.0)
    static let purple = UIColor(red:0.71, green:0.53, blue:0.97, alpha:1.0)
}

extension UIColor{
    static var backgoundGray: UIColor {
        return Color.backgoundGray
    }
    class func getActionColor(alpha: Double) -> UIColor{
        return UIColor(red: 50/255, green: 77/255, blue: 92/255, alpha: CGFloat(alpha))
    }
    
    static var purple : UIColor {
        return Color.purple
    }
}
