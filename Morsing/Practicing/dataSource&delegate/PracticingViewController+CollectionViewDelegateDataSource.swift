//
//  PracticingViewController+CollectionViewDelegateDataSource.swift
//  Morsing
//
//  Created by Paloma Bispo on 12/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension PracticingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CodeCollectionViewCell", for: indexPath) as! CodeCollectionViewCell
        let imageBit = self.data[self.indexItem].morse[indexPath.row]
        var letters: [Letters] = []
        var numbers: [Numbers] = []

        if self.isLetter{
            guard let l = self.fetchingCoreData() as? [Letters] else {return UICollectionViewCell()}
            letters = l
            if imageBit == 1{
                if letters[indexItem].done{
                    cell.codeImage.image = UIImage.init(named: "hyColorful")
                    self.naviItem.leftBarButtonItem?.tintColor = UIColor.green
                    
                }else{
                    self.naviItem.leftBarButtonItem?.tintColor = UIColor.green

                    cell.codeImage.image = UIImage.init(named: "hy")
                }
            }else{
                if letters[indexItem].done{
                    cell.codeImage.image = UIImage.init(named: "dotColorful")
                    self.naviItem.leftBarButtonItem?.tintColor = UIColor.green

                    
                }else{
                    self.naviItem.leftBarButtonItem?.tintColor = UIColor.green
                    cell.codeImage.image = UIImage.init(named: "dot")
                }
            }
        }else{
            guard let n = self.fetchingCoreData() as? [Numbers] else {return UICollectionViewCell()}
            numbers = n
            if imageBit == 1{
                if numbers[indexItem].done{
                    cell.codeImage.image = UIImage.init(named: "hyColorful")
                    self.naviItem.leftBarButtonItem?.tintColor = UIColor.green

                }else{
                    self.naviItem.leftBarButtonItem?.tintColor = UIColor.green
                    cell.codeImage.image = UIImage.init(named: "hy")
                }
            }else{
                if numbers[indexItem].done{
                    cell.codeImage.image = UIImage.init(named: "dotColorful")
                    self.naviItem.leftBarButtonItem?.tintColor = UIColor.green

                }else{
                    self.naviItem.leftBarButtonItem?.tintColor = UIColor.green
                    cell.codeImage.image = UIImage.init(named: "dot")
                }
            }
        }
        
        
        
        
        return cell
    }
    
    private func fetchingCoreData() -> [NSManagedObject]?{
        if self.isLetter{
            guard let entity = CoreDataManager.shared.getEntityDescription(entityName: "Letters") else {return nil}
            let result = CoreDataManager.shared.getAll(entity: entity)
            if result.success{
                guard let letters = result.objects as? [Letters] else {return nil}
                return letters
            }else{
                return nil
            }
            
        }else{
            guard let entity = CoreDataManager.shared.getEntityDescription(entityName: "Numbers") else {return nil}
            let result = CoreDataManager.shared.getAll(entity: entity)
            if result.success{
                guard let numbers = result.objects as? [Numbers] else {return nil}
                return numbers
            }else{
                return nil
            }
        }
    }
    
    
    
}
