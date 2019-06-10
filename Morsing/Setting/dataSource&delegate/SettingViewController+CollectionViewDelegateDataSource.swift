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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return settingOptions.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Settings"
        case 1:
            return "About"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            let item = settingOptions[indexPath.row]
            cell.textLabel?.text = item
            let switchAccessory = UISwitch()
            switchAccessory.tag = indexPath.row
            switchAccessory.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
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
            cell.selectionStyle = .none
            cell.accessoryView =  switchAccessory
            return cell
        } else {
            cell.textLabel?.text = "Start Tutorial"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            present(OnboardingViewController(), animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //switch Changed
    @objc private func switchChanged(sender: UISwitch) {
        if let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) {
            guard let text = cell.textLabel?.text else {return}
                sender.isOn = !sender.isOn
                switch text {
                case "Vibrations":
                    SettingManager.setVibrating(sender.isOn)
                case "Sound":
                    SettingManager.setSound(sender.isOn)
                default:
                    break
                }
        }
    }
}
