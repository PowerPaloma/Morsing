//
//  CutOutShape.swift
//  Morsing
//
//  Created by Levy Cristian  on 24/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class CutOutShape: UIView {
    
    private(set) lazy var maskLayer : CAShapeLayer = {
        let mask = CAShapeLayer(layer: self.layer)
        mask.frame = self.bounds
        mask.fillColor = UIColor.black.cgColor
        
        let circleRect = CGRect(x: position.x, y: position.y, width: radius*2, height: radius*2)
     
        let path = UIBezierPath(ovalIn: circleRect)
        path.append(UIBezierPath(rect: self.bounds))
        
        mask.path = path.cgPath
        mask.fillRule = CAShapeLayerFillRule.evenOdd
        
        return mask
    }()
    
    
    private lazy var rect : UIBezierPath = {
        let circleRect = CGRect(x: position.x, y: position.y, width: radius*2, height: radius*2)
        
        let path = UIBezierPath(ovalIn: circleRect)
        path.append(UIBezierPath(rect: self.bounds))
        
        return path
    }()
    
    private var radius : CGFloat = 0
    private(set) var position: CGPoint = CGPoint()
    private var spotlightPaths: [UIBezierPath] = []
    
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
    
    required init(frame: CGRect,fristObjectLocation at: CGPoint,withRadius radius: CGFloat = 50){
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        //autoresizingMask = []
        self.radius = radius
        self.position = at
        
    }
    
    override func didMoveToSuperview() {
        self.fillSuperview()
        self.layer.mask = maskLayer
        self.addSubview(nextButton)
        nextButton.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        nextButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDraggableSpotlight(withCenter center: CGPoint, radius: CGFloat) {
        let path = UIBezierPath(ovalIn: CGRect(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2 * radius))
        spotlightPaths.append(path)
        setNeedsLayout()
    }
    
    func moveTo(element: UIView, paternView: UIView){
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
            
               self.maskLayer.position = element.getPosition(inView: paternView)
            }, completion: nil)
        }
    }

}
