//
//  CharactersViewController+CollectionViewDelegateDataSource.swift
//  Morsing
//
//  Created by Paloma Bispo on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCollectionViewCell", for: indexPath) as! CharactersCollectionViewCell
        let item = self.data[indexPath.row]
        cell.custonContent.backgroundColor = self.backgroundColor
        cell.textLabel.textColor = self.textColor
        cell.textLabel.text = item.getCharacter(isLetter: isLetter)
        guard let done = item.getDone(isLetter: isLetter) else {return UICollectionViewCell()}
        cell.insignia.isHidden = !done
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 72)/3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 16, bottom: 20, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexSelect = indexPath.row
        let practicingVC = PracticingViewController()
        practicingVC.indexItem = indexSelect
        practicingVC.data = self.data
        practicingVC.isLetter = self.isLetter
        self.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(practicingVC, animated: true)
        
    }
    
}
