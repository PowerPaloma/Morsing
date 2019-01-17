//
//  UIColor.swift
//  Morsing
//
//  Created by Paloma Bispo on 14/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit


extension UIColor {
    
    class func getActionColor(alpha: Double) -> UIColor{
        return UIColor(red: 50/255, green: 77/255, blue: 92/255, alpha: CGFloat(alpha))
    }
    class func getBackgroundViewColor() -> UIColor{
        return UIColor(red:238/255, green:241/255, blue:245/255, alpha:1.0)
    }
    
}
