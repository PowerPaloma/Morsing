//
//  AppDelegate.swift
//  Morsing
//
//  Created by Paloma Bispo on 07/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var learningTabNavControler: UINavigationController!
    var translateTabNavControler: UINavigationController!

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let tabBarController = UITabBarController()
        setup(tabBarController: tabBarController)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        setupCoreData()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataManager.shared.saveContext()
    }
    
    // MARK: - TabBar Setup
    
    func setup(tabBarController: UITabBarController){
        let learningViewController = LearningViewController()
        let translateViewController = TranslateMenuViewController()
        learningViewController.title = "Learning"
        translateViewController.title = "Translate"
        let learningItem = UITabBarItem(title: "Learning", image: #imageLiteral(resourceName: "learning"), tag: 0)
        let translateItem = UITabBarItem(title: "Translate", image: #imageLiteral(resourceName: "translate"), tag: 1)
        learningTabNavControler = UINavigationController.init(rootViewController: learningViewController)
        translateTabNavControler = UINavigationController.init(rootViewController: translateViewController)
        learningTabNavControler.tabBarItem = learningItem
        translateTabNavControler.tabBarItem = translateItem
        tabBarController.viewControllers = [learningTabNavControler, translateTabNavControler]
    }
    
    // MARK: - CoreData Setup
    
    func setupCoreData(){
        guard let letters = Item.letters(), let numbers = Item.numbers() else {return}
        for (index, _) in letters.enumerated() {
            let letter = Letters(context: CoreDataManager.shared.getContext())
            letter.done = false
            letter.index = Int16(index)
        }
        for (index, _) in numbers.enumerated(){
            let number = Numbers(context: CoreDataManager.shared.getContext())
            number.done = false
            number.index = Int16(index)
        }
    }

}

