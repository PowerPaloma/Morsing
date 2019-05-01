//
//  DimmingView.swift
//  Morsing
//
//  Created by Levy Cristian  on 19/04/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class DimmingView: UIView {
    private var fillLayer: CAShapeLayer?
    private var dimmingOpacity: Float = 0.9
    private var dimmingColor: UIColor = .black
    
    
    
    private var dimmedPath: UIBezierPath? {
        didSet{
            updatePaths(withVisiblePath: visiblePath)
        }
    }
    
    private var visiblePath: UIBezierPath? {
        didSet{
            updatePaths(withVisiblePath: visiblePath)
        }
    }
    
    // MARK: - updating visible paths
    func updatePaths(withVisiblePath visiblePath: UIBezierPath?) {
        fillLayer?.removeFromSuperlayer()
        
        visiblePath?.usesEvenOddFillRule = true
        
        var dimmedPath: UIBezierPath? = nil
        if let CGPath = self.dimmedPath?.cgPath {
            dimmedPath = UIBezierPath(cgPath: CGPath)
        }
        
        if let visiblePath = visiblePath {
            dimmedPath?.append(visiblePath)
        }
        dimmedPath?.usesEvenOddFillRule = true
        
        fillLayer = CAShapeLayer()
        fillLayer?.path = dimmedPath?.cgPath
        fillLayer?.fillRule = .evenOdd
        fillLayer?.fillColor = dimmingColor.cgColor
        fillLayer?.opacity = dimmingOpacity
        
        if let fillLayer = fillLayer {
            layer.addSublayer(fillLayer)
        }
    }
}
