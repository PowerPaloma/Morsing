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
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 6.0
        button.layer.masksToBounds = false
        button.setTitle("Text", for: UIControl.State.normal)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.71)
        button.setTitleColor(UIColor.getActionColor(alpha: 1.0), for: UIControl.State.normal)
        button.setTitleColor(UIColor.getActionColor(alpha: 0.5), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var morseButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 6.0
        button.layer.masksToBounds = false
        button.setTitle("Morse", for: UIControl.State.normal)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.71)
        button.setTitleColor(UIColor.getActionColor(alpha: 1.0), for: UIControl.State.normal)
        button.setTitleColor(UIColor.getActionColor(alpha: 0.5), for: UIControl.State.highlighted)
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
