//
//  Onboard.swift
//  Morsing
//
//  Created by Levy Cristian  on 05/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import Foundation

enum OnboardingAssetsOpition: String {
    case animation = "animation"
    case image = "image"
}

struct Onboard {
    let title : String
    let description: String
    let assetName: String
    let assetKind: OnboardingAssetsOpition
    
    init(title: String, description: String, assetName: String, assetKind: OnboardingAssetsOpition) {
        self.title = title
        self.description = description
        self.assetName = assetName
        self.assetKind = assetKind
    }
}
