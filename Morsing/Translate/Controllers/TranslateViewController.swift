//
//  TranslateViewController.swift
//  Morsing
//
//  Created by Levy Cristian  on 10/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    fileprivate lazy var translateView: Translate = {
        let view = Translate()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       view.setGradientToView(colors: [UIColor(red:0.11, green:0.90, blue:0.89, alpha:1.0).cgColor,UIColor(red:0.71, green:0.53, blue:0.97, alpha:1.0).cgColor])
    }
    override func viewWillAppear(_ animated: Bool) {
        setUP()
        translateView.setUP()
    }
    
    fileprivate func setUP(){
        addViws()
        setUPConstraints()
    }
    
    fileprivate func addViws(){
        view.addSubview(translateView)
    }
    
    fileprivate func setUPConstraints(){
        translateView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
       
    }
}
