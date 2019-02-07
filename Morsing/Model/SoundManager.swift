//
//  SoundManager.swift
//  Morsing
//
//  Created by Paloma Bispo on 07/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit
import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    
    func soundOf(message: [Int]) -> AVQueuePlayer?{
        var audioItems: [AVPlayerItem] = []
        guard let longPath = Bundle.main.path(forResource: "beep_long", ofType: "mp3"),
            let shortPath = Bundle.main.path(forResource: "beep_short", ofType: "mp3") else {
                print("Path is not availabel")
                return AVQueuePlayer()
        }
        for code in message {
            if code == 1 {
                let longBeep = AVPlayerItem(url: URL(fileURLWithPath: longPath))
                audioItems.append(longBeep)
            } else {
                let shortBeep = AVPlayerItem(url: URL(fileURLWithPath: shortPath))
                audioItems.append(shortBeep)
            }
        }
        return AVQueuePlayer(items: audioItems)
    }

}
