//
//  SettingViewController.swift
//  Morsing
//
//  Created by Paloma Bispo on 20/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    let settingOptions = ["Vibrations", "Sound"]
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.alwaysBounceVertical = true
        table.showsVerticalScrollIndicator = false
        table.tableFooterView = UIView()
        view.addSubview(table)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        settingConstraints()
        settingTable()
    }
    
    private func settingConstraints(){
        if let superview = tableView.superview {
            tableView.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    private func settingTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
//    @objc private func switchValueChanged(){
//        if let cell = tableView.cellForRow(at: indexPath) {
//            guard let text = cell.textLabel?.text else {return}
//            if let switchAcces = cell.accessoryView as? UISwitch {
//                switchAcces.isOn = !switchAcces.isOn
//                switch text {
//                case "Vibrations":
//                    SettingManager.setVibrating(!switchAcces.isOn)
//                case "Sound":
//                    SettingManager.setSound(!switchAcces.isOn)
//                default:
//                    break
//                }
//            }
//        }
//    }


}
