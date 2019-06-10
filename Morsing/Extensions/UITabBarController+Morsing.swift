//
//  UITabBarController+Morsing.swift
//  Morsing
//
//  Created by Levy Cristian  on 05/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    // MARK: - TabBar Setup
    
    func setup(){
        let learningViewController = LearningViewController()
        let translateViewController = TranslateMenuViewController()
        learningViewController.title = "Learning"
        translateViewController.title = "Translate"
        let learningItem = UITabBarItem(title: "Learning", image: #imageLiteral(resourceName: "learning"), tag: 0)
        let translateItem = UITabBarItem(title: "Translate", image: #imageLiteral(resourceName: "translate"), tag: 1)
        let learningTabNavControler = UINavigationController.init(rootViewController: learningViewController)
        let translateTabNavControler = UINavigationController.init(rootViewController: translateViewController)
        learningTabNavControler.navigationBar.tintColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)
        translateTabNavControler.navigationBar.tintColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)
        learningTabNavControler.tabBarItem = learningItem
        translateTabNavControler.tabBarItem = translateItem
        self.viewControllers = [learningTabNavControler, translateTabNavControler]
        self.tabBar.tintColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)

    }
}
