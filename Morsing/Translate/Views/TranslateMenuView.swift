//
//  Translate.swift
//  Morsing
//
//  Created by Levy Cristian  on 10/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class TranslateMenuView: UIView {

    public lazy var textButton: UIButton = {
        let button = UIButton()
        //button.addTarget(self, action: #selector(textButtonDidClicled), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitle("Text", for: UIControl.State.normal)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor(red:0.93, green:0.95, blue:0.96, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var morseButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Morse", for: UIControl.State.normal)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor(red:0.93, green:0.95, blue:0.96, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate var arrowsImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "arrows")
        
        imageView.image = image
        
       return imageView
    }()
    
    public func setUP(){
        addViews()
        setUPConstraints()
    }
    
    fileprivate func addViews(){
        self.addSubview(textButton)
        self.addSubview(morseButton)
        self.addSubview(arrowsImage)
    }
    
    fileprivate func setUPConstraints(){
        textButton.translatesAutoresizingMaskIntoConstraints = false
        textButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        textButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45).isActive = true
        textButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        
        morseButton.translatesAutoresizingMaskIntoConstraints = false
        morseButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        morseButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45).isActive = true
        morseButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        arrowsImage.translatesAutoresizingMaskIntoConstraints = false
        arrowsImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        arrowsImage.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    
}
