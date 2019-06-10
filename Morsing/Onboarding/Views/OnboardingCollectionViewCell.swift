//
//  OnboardingCollectionViewCell.swift
//  Morsing
//
//  Created by Levy Cristian  on 05/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    fileprivate var customContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate lazy var animationView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate lazy var imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    public var assetOpition: OnboardingAssetsOpition? {
        didSet {
           setupViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addViews() {
        addSubview(customContentView)
        if assetOpition == .animation {
            customContentView.addSubview(animationView)
        }else{
            customContentView.addSubview(imageCell)
        }
        
        customContentView.addSubview(titleLabel)
        customContentView.addSubview(descriptionLabel)
        
    }
    
    private func setupViews() {
        addViews()
        
        customContentView.fillSuperview()
        
        if assetOpition == .animation {
            animationView.anchor(top: customContentView.safeAreaLayoutGuide.topAnchor, leading: customContentView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: customContentView.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: .zero)
            animationView.heightAnchor.constraint(equalTo: customContentView.heightAnchor, multiplier: 0.7).isActive = true
            
            titleLabel.anchor(top: animationView.bottomAnchor, leading: customContentView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: customContentView.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 8, bottom: 0, right: 8), size: .zero)
        }else{
            imageCell.anchor(top: customContentView.safeAreaLayoutGuide.topAnchor, leading: customContentView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: customContentView.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: .zero)
            imageCell.heightAnchor.constraint(equalTo: customContentView.heightAnchor, multiplier: 0.7).isActive = true
            
            titleLabel.anchor(top: imageCell.bottomAnchor, leading: customContentView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: customContentView.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 8, bottom: 0, right: 8), size: .zero)
        }
        
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: customContentView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: customContentView.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 8, bottom: 0, right: 8), size: .zero)
        
    }
    
//    func addAnimation(aniamtionName: String){
//        let animationView = LOTAnimationView(name: aniamtionName, bundle: Bundle.main)
//        self.animationView.addSubview(animationView)
//        animationView.fillSuperview(safeArea: true)
//        animationView.play()
//    }
    
    func setImage(name: String){
        self.imageCell.image = UIImage(named: name)
    }
    
}
