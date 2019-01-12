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
    
    lazy var navigationBar: UINavigationBar = {
       let navigation = UINavigationBar()
        navigation.translatesAutoresizingMaskIntoConstraints = false
        return navigation
    }()
    
    lazy var naviItem: UINavigationItem = {
        let nav = UINavigationItem()
         let reset = UIBarButtonItem(title: "Reset", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(resetAction))
        reset.tintColor = UIColor(red: 226/255, green: 17/255, blue: 17/255, alpha: 1.0)
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(doneAction))
        done.tintColor = UIColor(red: 50/255, green: 77/255, blue: 92/255, alpha: 1.0)
        nav.rightBarButtonItem = done
        nav.leftBarButtonItem = reset
        return nav
    }()
    
    lazy var doneButton: UINavigationItem = {
        let done = UINavigationItem()
        let button = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(doneAction))
        button.tintColor = UIColor(red: 50/255, green: 77/255, blue: 92/255, alpha: 1.0)
        done.rightBarButtonItem = button
        return done
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
        settingNavigationBar()
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
        view.addSubview(navigationBar)
        view.addSubview(toolBar)
        view.addSubview(tapView)
    }
    
    private func settingNavigationBar(){
        navigationBar.setItems([naviItem], animated: true)
        
    }
    
    private func settingConstraints(){
        if let superview = toolBar.superview{
            toolBar.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
            toolBar.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
            toolBar.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
}
