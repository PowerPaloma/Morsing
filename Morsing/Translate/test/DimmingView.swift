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
    
    private var dimmedPath : UIBezierPath?{
        didSet{
            updatePaths(withVisiblePath: visiblePath)
            
        }
    }
    
    
    public var visiblePath: UIBezierPath? {
        didSet{
            updatePaths(withVisiblePath: visiblePath)
            
        }
    }
    
    public lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Text", for: UIControl.State.normal)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor(red:0.93, green:0.95, blue:0.96, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    init(frame: CGRect, opacity: Float, visiblePath: UIBezierPath) {
        super.init(frame: frame)
//        self.backgroundColor = dimmingColor
//        self.alpha = CGFloat(opacity)
//
        self.dimmingOpacity = opacity
        self.visiblePath = visiblePath
        dimmedPath = UIBezierPath(rect: self.bounds)

      
    }
    override func didMoveToSuperview() {
        updatePaths(withVisiblePath: visiblePath)
        self.addSubview(nextButton)
        nextButton.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        nextButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            self.layer.addSublayer(fillLayer)
        }
    }
}
