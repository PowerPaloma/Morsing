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
        
    }
    
    fileprivate func setUPConstraints(){
        
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
