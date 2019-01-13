//
//  TranslateViewController.swift
//  Morsing
//
//  Created by Levy Cristian  on 10/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class TranslateMenuViewController: UIViewController {

    fileprivate lazy var translateMenuView: TranslateMenuView = {
        let view = TranslateMenuView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       view.setGradientToView(opition: .defalt)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setUP()
        translateMenuView.setUP()
        navigationBarSetup()
        tabBarSetup()
    }
    
    fileprivate func setUP(){
        addViws()
        setUPConstraints()
        translateMenuView.textButton.addTarget(self, action: #selector(textButtonDidClicled), for: UIControl.Event.touchUpInside)
        translateMenuView.morseButton.addTarget(self, action: #selector(morseButtonDidClicled), for: UIControl.Event.touchUpInside)
    }
    
    fileprivate func addViws(){
        view.addSubview(translateMenuView)
    }
    
    fileprivate func setUPConstraints(){
        translateMenuView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
       
    }
    
    @objc fileprivate func textButtonDidClicled(){
        let destination = TranslateViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
    
    @objc fileprivate func morseButtonDidClicled(){
        let destination = TranslateViewController()
        destination.isTranslateToMorse = true
        navigationController?.pushViewController(destination, animated: true)
    }
    
    fileprivate func navigationBarSetup(){
        navigationController?.navigationBar.barTintColor = nil
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isOpaque = true
        
    }
    fileprivate func tabBarSetup(){
        tabBarController?.tabBar.barTintColor = nil
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isOpaque = true
    }
}
