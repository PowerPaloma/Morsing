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
        guard let morse = data[indexItem].getMorse(isLetter: isLetter) else {return 0 }
        return morse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CodeCollectionViewCell", for: indexPath) as! CodeCollectionViewCell
        guard let morse = data[indexItem].getMorse(isLetter: isLetter) else {return UICollectionViewCell()}
        let imageBit = morse[indexPath.row]
        guard let characters = CoreDataManager.shared.fetching(isLetterData: isLetter), let done = characters[indexItem].getDone(isLetter: isLetter) else {return UICollectionViewCell()}
        if imageBit == 1{
            if done {
                cell.codeImage.image = UIImage.init(named: "hyColorful")
                self.resetButton.isHighlighted = false
                self.resetButton.isEnabled = true
            }else{
                cell.codeImage.image = UIImage.init(named: "hy")
                self.resetButton.isHighlighted = true
                self.resetButton.isEnabled = false
            }
        }else{
            if done{
                cell.codeImage.image = UIImage.init(named: "dotColorful")
                self.resetButton.isHighlighted = false
                self.resetButton.isEnabled = true
            }else{
                cell.codeImage.image = UIImage.init(named: "dot")
                self.resetButton.isHighlighted = true
                self.resetButton.isEnabled = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // doing the cells in the middle of collection
        let totalCellWidth = 60*collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets.init(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: collectionView.frame.height)
    }
}
