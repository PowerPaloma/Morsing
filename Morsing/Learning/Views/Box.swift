//
//  Box.swift
//  Morsing
//
//  Created by Levy Cristian  on 10/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class Box: UIView {
    
    fileprivate var lettersLabel: UILabel = {
        let label = UILabel()
        label.text = "L"
        label.textColor = UIColor.getActionColor(alpha: 1.0)
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 80)
        return label
    }()
    
    fileprivate var lettersButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 6.0
        button.layer.masksToBounds = false
        button.setTitle("Letters", for: UIControl.State.normal)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.71)
        button.setTitleColor(UIColor.getActionColor(alpha: 1.0), for: UIControl.State.normal)
        //button.setTitleColor(UIColor(red:0.12, green:0.27, blue:0.24, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate var numbersLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = UIColor.getActionColor(alpha: 1.0)
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 80)
        return label
    }()
    
    fileprivate var numbersButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Numbers", for: UIControl.State.normal)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.71)
        button.setTitleColor(UIColor.getActionColor(alpha: 1.0), for: UIControl.State.normal)
        //button.setTitleColor(UIColor(red:0.12, green:0.27, blue:0.24, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 6.0
        button.layer.masksToBounds = false
        return button
    }()
    
    public override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(1)
        context!.setStrokeColor(UIColor.white.cgColor)
        
        context?.move(to: CGPoint(x: self.frame.width, y: 0))
        context?.addLine(to: CGPoint(x: 0, y: self.frame.height))
        context!.strokePath()
    }
    
    public func setUp(){
        addViews()
        setUpConstraints()
    }
    
    fileprivate func addViews(){
        self.addSubview(lettersLabel)
        self.addSubview(lettersButton)
        self.addSubview(numbersLabel)
        self.addSubview(numbersButton)
    }
    fileprivate func setUpConstraints(){
        
        lettersLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 50, left: 70, bottom: 0, right: 0), size: .zero)
        lettersButton.anchor(top: lettersLabel.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0), size: .zero)
        lettersButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        
        numbersLabel.anchor(top: nil, leading: nil, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 70), size: .zero)
        numbersButton.anchor(top: nil, leading: nil, bottom: numbersLabel.topAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10), size: .zero)
        numbersButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        
    }

}
