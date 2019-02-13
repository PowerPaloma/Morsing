//
//  CharactersCollectionViewCell.swift
//  Morsing
//
//  Created by Paloma Bispo on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    
    private weak var shadowView: UIView?
    
    lazy var custonContent: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 65)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var insignia: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "badge")
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addConstraint(){
        if let superview = custonContent.superview {
            custonContent.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            custonContent.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            custonContent.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            custonContent.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        }
        if let superview = insignia.superview {
            insignia.topAnchor.constraint(equalTo: custonContent.topAnchor, constant: 4).isActive = true
            insignia.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.25).isActive = true
            insignia.widthAnchor.constraint(equalTo: insignia.heightAnchor).isActive = true
            insignia.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -4).isActive = true
        }
        textLabel.centerXAnchor.constraint(equalTo: custonContent.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: custonContent.centerYAnchor).isActive = true
    }
    
    private func setup(){
        addSubview(custonContent)
        custonContent.addSubview(textLabel)
        custonContent.addSubview(insignia)
        addConstraint()
    }
    
    private func configureShadow(){
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width + 5 , height: bounds.height + 5))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        self.applyShadow(width: CGFloat(0), height: CGFloat(1))
    }
    
    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView{
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 15)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 1.5
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.2
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadow()
    }
    
}
