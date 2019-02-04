//
//  CodeCollectionViewCell.swift
//  Morsing
//
//  Created by Paloma Bispo on 12/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class CodeCollectionViewCell: UICollectionViewCell {
    
    lazy var custonContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgoundGray
        return view
    }()
    
    lazy var codeImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup(){
        addSubview(custonContainer)
        custonContainer.addSubview(codeImage)
        settingConstraints()
    }
    
    private func settingConstraints(){
        custonContainer.fillSuperview(safeArea: false)
        codeImage.fillSuperview(safeArea: false)
        
    }
    
    
    
}
