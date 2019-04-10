//
//  SettingManager.swift
//  Morsing
//
//  Created by Paloma Bispo on 20/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class SettingManager: NSObject {

    
    static func setVibrating(_ vibration: Bool){
        UserDefaults.standard.set(vibration, forKey: "vibration")
    }
    static func getVibration() -> Bool {
        return UserDefaults.standard.bool(forKey: "isVibrating")
    }
    static func setSound(_ sound: Bool){
        UserDefaults.standard.set(sound, forKey: "isSound")
    }
    static func getSound() -> Bool {
        return UserDefaults.standard.bool(forKey: "isSound")
    }
}
