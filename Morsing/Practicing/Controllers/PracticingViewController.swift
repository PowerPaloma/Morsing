//
//  PracticingViewController.swift
//  Morsing
//
//  Created by Paloma Bispo on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class PracticingViewController: UIViewController {
    
    var player: AVQueuePlayer?
    var data: [Item] = []
    var currentIndex = 0
    var firtAccess = false
    var isLetter: Bool!
    var indexItem = 0
    
    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.backgroundColor = UIColor.white
        return toolBar
    }()
    
    lazy var custonNaviBar: UIView = {
       let nav = UIView()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = UIColor.white
        return nav
    }()
    
    lazy var resetButton: UIButton = {
        let reset = UIButton()
        reset.translatesAutoresizingMaskIntoConstraints = false
        reset.setTitle("Reset", for: UIControl.State.normal)
        reset.setTitleColor(UIColor(red: 226/255, green: 17/255, blue: 17/255, alpha: 1.0), for: UIControl.State.normal)
        reset.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        reset.target(forAction: #selector(resetAction), withSender: nil)
        return reset
    }()
    
    lazy var doneButton: UIButton = {
        let done = UIButton()
        done.translatesAutoresizingMaskIntoConstraints = false
        done.setTitle("Done", for: UIControl.State.normal)
        done.setTitleColor(UIColor(red: 50/255, green: 77/255, blue: 92/255, alpha: 1.0), for: UIControl.State.normal)
        done.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        done.target(forAction: #selector(doneAction), withSender: nil)
        return done
    }()
    
    lazy var soundButton: UIButton = {
        let sound = UIButton()
        sound.translatesAutoresizingMaskIntoConstraints = false
        sound.vi
        setGradientToView(colors: [UIColor(red:0.11, green:0.90, blue:0.89, alpha:1.0).cgColor,UIColor(red:0.71, green:0.53, blue:0.97, alpha:1.0).cgColor])
        sound.translatesAutoresizingMaskIntoConstraints = false
        sound.setImage(UIImage(named: "sound"), for: .normal)
        sound.target(forAction: #selector(soundAction), withSender: nil)
        return sound
    }()
    
    lazy var tapView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var CodeCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .clear
        collection.alwaysBounceVertical = false
        collection.alwaysBounceHorizontal = false
        collection.showsHorizontalScrollIndicator = false
        let collectionViewLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.scrollDirection = .horizontal
        return collection
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:238/255, green:241/255, blue:245/255, alpha:1.0)
        addviews()
        settingToolBar()
        settingConstraints()

    }
    
    // MARK: - Settings
    
    private func settingToolBar(){
        let back: UIBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target: self, action: #selector(backAction))
        let next: UIBarButtonItem = UIBarButtonItem(title: "Next", style:.plain, target: self, action: #selector(nextAction))
        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target:  nil, action: nil)
        toolBar.items = [back, flexibleSpace, next]
    }
    
    private func addviews(){
        view.addSubview(custonNaviBar)
        view.addSubview(toolBar)
        view.addSubview(tapView)
        view.addSubview(soundButton)
        custonNaviBar.addSubview(doneButton)
        custonNaviBar.addSubview(resetButton)
    }
    
    
    private func settingConstraints(){
        // constraints in toolBar
        if let superview = toolBar.superview{
            toolBar.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
            toolBar.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
            toolBar.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        //constraints in custonNavBar
        if let superview = custonNaviBar.superview{
            custonNaviBar.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
            custonNaviBar.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
            custonNaviBar.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            custonNaviBar.heightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        }
        //constraints in doneButton
        doneButton.trailingAnchor.constraint(equalTo: custonNaviBar.trailingAnchor, constant: -8).isActive = true
        doneButton.leadingAnchor.constraint(greaterThanOrEqualTo: resetButton.trailingAnchor, constant: 8).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: custonNaviBar.centerYAnchor, constant: 8).isActive = true
        //constraints in resetButton
        resetButton.leadingAnchor.constraint(equalTo: custonNaviBar.leadingAnchor, constant: 8).isActive = true
        resetButton.centerYAnchor.constraint(equalTo: doneButton.centerYAnchor).isActive = true
        //constraints soundButton
        if let superview = soundButton.superview{
            soundButton.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
             soundButton.topAnchor.constraint(equalTo: custonNaviBar.bottomAnchor, constant: 16).isActive = true
            soundButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            soundButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
    }
    
  
    
    // MARK: - Actions
    
    @objc func resetAction(){
        
    }
    
    @objc func doneAction(){
        
    }
    
    @objc func nextAction(){
//        currentIndex = 0
//        print(currentIndex)
//        self.indexItem += 1
//        if (indexItem > data.count - 1){
//            self.indexItem = 0
//            label.text = data[indexItem].name
//            codeCollection.reloadData()
//        }else{
//            label.text = array[indexItem].name
//            codeCollection.reloadData()
//            
//        }
    }
    @objc func backAction(){
        
    }
    
    @objc func soundAction(){
        
    }
}
