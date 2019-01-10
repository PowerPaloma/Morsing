//
//  Box.swift
//  Morsing
//
//  Created by Levy Cristian  on 10/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class Box: UIView {

    public override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(1)
        context!.setStrokeColor(UIColor.white.cgColor)
        
        context?.move(to: CGPoint(x: self.frame.width, y: 0))
        context?.addLine(to: CGPoint(x: 0, y: self.frame.height))
        context!.strokePath()
    }

}
