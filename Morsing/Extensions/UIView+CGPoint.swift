//
//  UIView+CGPoint.swift
//  Morsing
//
//  Created by Levy Cristian  on 19/04/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

extension UIView {
    
    private func getRealtiveCenterPositionInSuperView() -> CGPoint {

        return CGPoint(x: self.bounds.origin.x - self.frame.width/2 , y: self.bounds.origin.y - self.frame.height/2)
    }
    
    func getPosition(inView: UIView)-> CGPoint{
        
        return self.convert(getRealtiveCenterPositionInSuperView(), to: inView)
        
    }
}
