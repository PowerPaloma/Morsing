//
//  LearningViewController.swift
//  Morsing
//
//  Created by Paloma Bispo on 07/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class LearningViewController: UIViewController {
    
    fileprivate lazy var boxView: Box = {
        let view = Box()
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        return tap
    }()
    
    fileprivate lazy var setting: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.addTarget(self, action: #selector(settingAction), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientToView(opition: .Default)
        navigationItem.setRightBarButton(setting, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        setUp()
        tap.addTarget(self, action: #selector(tapAction))
        tabBarSetup()
        navigationBarSetup()
    }
    
    // MARK: - Setups
    fileprivate func setUp(){
        addViews()
        setUPConstrants()
        boxView.setUp()
        tap.addTarget(self, action: #selector(tapAction))
        boxView.addGestureRecognizer(tap)
    }
    
    fileprivate func addViews(){
        view.addSubview(boxView)
    }
    
    fileprivate func setUPConstrants(){
        boxView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    fileprivate func tapWasInLetter(area: CGSize, tapLocation: CGPoint) -> Bool{
        //Slope is the variation of a diagonal screen, we goign to use slove point o calculate the poins in screem.
        let slope = area.height/area.width
        let x1 = area.width
        let y1 = CGFloat(0.0)
        
        //calculating the limit of touch
        let limitOfY = abs((slope * (tapLocation.x - x1)) + y1)
        
        if (tapLocation.y <= limitOfY){
            return true
        }
        return false
    }
    
    // MARK: - Actions
    
    @objc fileprivate func tapAction(_ sender: UITapGestureRecognizer){
        let tapLocation = sender.location(in: boxView)
        let charactersVC = CharactersViewController()
        
        if tapWasInLetter(area: boxView.frame.size, tapLocation: tapLocation){
            charactersVC.isLetter = true
        }else{
            charactersVC.isLetter = false
        }
        navigationController?.pushViewController(charactersVC, animated: true)
    }
    
    @objc func settingAction(){
        let settingVC = SettingViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    fileprivate func tabBarSetup(){
        tabBarController?.tabBar.barTintColor = nil
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isOpaque = true
    }
    
    fileprivate func navigationBarSetup(){
        navigationController?.navigationBar.barTintColor = nil
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isOpaque = true
        
    }
}
