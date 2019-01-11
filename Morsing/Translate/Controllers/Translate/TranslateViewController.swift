//
//  TranslateViewController.swift
//  Morsing
//
//  Created by Levy Cristian  on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    public var isTranslateToMorse: Bool = false
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        scroll.bounces = true
        scroll.alwaysBounceVertical = true
    
        return scroll
    }()
    
    fileprivate lazy var conteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.93, green:0.95, blue:0.96, alpha:1.0)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUp()
    }
    
    fileprivate func setUp(){
        isTranslateToMorse ? navigationBarSetup(name: "Morse") :  navigationBarSetup(name: "Text")
        tabBarSetup()
        addViews()
        setUPConstraints()
    }
     
    fileprivate func addViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(conteinerView)
        //conteinerView.addSubview(view2)
    }
    
    fileprivate func setUPConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        conteinerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        conteinerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        conteinerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1, constant: 0).isActive = true
        

    }

    fileprivate func navigationBarSetup(name: String) {
        
        navigationItem.title = name
        navigationController?.navigationBar.tintColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false
        
    }
    fileprivate func tabBarSetup(){
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.isOpaque = false
        
    }

}
