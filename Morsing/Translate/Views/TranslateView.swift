//
//  TranslateView.swift
//  Morsing
//
//  Created by Levy Cristian  on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class TranslateView: UIView {
    
    fileprivate weak var shadowView1: UIView?
    fileprivate weak var shadowView2: UIView?
    
    fileprivate lazy var fristView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    fileprivate lazy var responseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    
    public func setUP(){
        addViews()
        setUpConstraints()
    }
    
    fileprivate func addViews(){
        self.addSubview(fristView)
        self.addSubview(responseView)
    }
    
    fileprivate func setUpConstraints(){
        fristView.translatesAutoresizingMaskIntoConstraints = false
        fristView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        fristView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        fristView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        fristView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        responseView.translatesAutoresizingMaskIntoConstraints = false
        responseView.topAnchor.constraint(equalTo: fristView.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        responseView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        responseView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        responseView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    }
    
    private func configureShadow() {
        // Shadow View
        self.shadowView1?.removeFromSuperview()
        self.shadowView2?.removeFromSuperview()
        
        let shadowView1 = UIView(frame: CGRect(x: 0, y: 0, width: self.fristView.bounds.width + 5 , height: self.fristView.bounds.height + 5))
        insertSubview(shadowView1, belowSubview: self.fristView)
        shadowView1.center = self.fristView.center
        
        self.shadowView1 = shadowView1
        
        let shadowView2 = UIView(frame: CGRect(x: 0, y: 0, width: self.responseView.bounds.width + 5 , height: self.responseView.bounds.height + 5))
        insertSubview(shadowView2, belowSubview: self.responseView)
        shadowView2.center = self.responseView.center
        
        self.shadowView2 = shadowView2
        
    
        self.applyShadow(view: self.shadowView1!,width: CGFloat(0), height: CGFloat(1))
        self.applyShadow(view: self.shadowView2!,width: CGFloat(0), height: CGFloat(1))
    }
    private func applyShadow(view: UIView, width: CGFloat, height: CGFloat) {
        
        let shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 15)
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowOpacity = 0.15
        view.layer.shadowPath = shadowPath.cgPath
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadow()
    }
}
