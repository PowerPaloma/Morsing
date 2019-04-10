//
//  File.swift
//  Morsing
//
//  Created by Paloma Bispo on 20/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = settingOptions[indexPath.row]
        cell.textLabel?.text = item
        let switchAccessory = UISwitch()
        switch item {
        case "Vibrations":
            switchAccessory.isOn = SettingManager.getVibration()
            break
        case "Sound":
            switchAccessory.isOn = SettingManager.getSound()
            break
        default:
            break
        }
        cell.accessoryView =  switchAccessory
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        if let cell = tableView.cellForRow(at: indexPath) {
            guard let text = cell.textLabel?.text else {return}
            if let switchAcces = cell.accessoryView as? UISwitch {
                switchAcces.isOn = !switchAcces.isOn
                switch text {
                case "Vibrations":
                    SettingManager.setVibrating(!switchAcces.isOn)
                case "Sound":
                    SettingManager.setSound(!switchAcces.isOn)
                default:
                    break
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
