//
//  CharactersViewController.swift
//  Morsing
//
//  Created by Paloma Bispo on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import CoreData

class CharactersViewController: UIViewController {
    
    var isLetter: Bool!
    var backgroundColor = UIColor()
    var textColor = UIColor()
    var data: [NSManagedObject] {
        get{
            guard let result = CoreDataManager.shared.fetching(isLetterData: isLetter) else {return []}
            return result
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .clear
        collection.alwaysBounceVertical = true
        collection.alwaysBounceHorizontal = false
        collection.showsVerticalScrollIndicator = false
        let collectionViewLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.scrollDirection = .vertical
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:238/255, green:241/255, blue:245/255, alpha:1.0)
        settingData()
        settingSubViews()
        settingCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingCollectionConstraints()
        collectionView.reloadData()
    }
    
    
    // MARK: - Settings
    
    private func settingData(){
        if isLetter {
            textColor = UIColor(red: 50/255, green: 77/255, blue: 92/255, alpha: 1)
            backgroundColor = UIColor(red: 29/255, green: 229/255, blue: 226/255, alpha: 1)
        }else{
            textColor = UIColor.white
            backgroundColor = UIColor(red: 181/255, green: 136/255, blue: 247/255, alpha: 1)
        }
    }
    
    private func settingCollectionConstraints(){
        if let superview = self.collectionView.superview {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
            collectionView.leadingAnchor.constraint(equalTo:
                superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
        }
    }
    
    private func settingSubViews(){
        view.addSubview(collectionView)
    }
    
    private func settingCollection(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: "CharactersCollectionViewCell")
    }  
    
}
