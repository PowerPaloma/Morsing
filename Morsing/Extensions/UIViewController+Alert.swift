//
//  UIViewController+Alert.swift
//  Morsing
//
//  Created by Levy Cristian  on 14/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func showAlert(title: String? = nil, menssage: String? = nil){
        
        let alert = UIAlertController(title: title, message: menssage, preferredStyle: .alert)
        
        if let navigation = self.navigationController{
            if let visibleViewController = navigation.visibleViewController {
                if !(visibleViewController.isKind(of: UIAlertController.self)) {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            self.present(alert, animated: true, completion: nil)
        }
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
            
        }
    }
}
