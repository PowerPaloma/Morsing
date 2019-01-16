//
//  NSManagerObject.swift
//  Morsing
//
//  Created by Paloma Bispo on 16/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import CoreData

extension NSManagedObject {
    
    func getDone(isLetter: Bool) -> Bool?{
        if isLetter {
            guard let l = self as? Letters else {return nil}
            return l.done
        }else{
            guard let n = self as? Numbers else {return nil}
            return n.done
        }
    }
    
    func set(done: Bool, isLetter: Bool){
        if isLetter {
            guard let l = self as? Letters else {return}
            l.done = done
        }else{
            guard let n = self as? Numbers else {return}
            n.done = done
        }
        CoreDataManager.shared.saveContext()
    }
    func getCharacter(isLetter: Bool) -> String?{
        if isLetter {
            guard let l = self as? Letters else {return nil}
            return l.letter
        }else{
            guard let n = self as? Numbers else {return nil}
            return n.number
        }
    }
    func getMorse(isLetter: Bool) -> [Int]?{
        var morse: [Int] = []
        if isLetter {
            guard let l = self as? Letters, let morseData = l.morse else {return nil}
            do {
                morse = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(morseData) as! [Int]
            }catch{
                print(error)
                return nil
            }
            return morse
        }else{
            var morse: [Int] = []
            guard let n = self as? Numbers, let morseData = n.morse else {return nil}
            do {
                morse = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(morseData) as! [Int]
            }catch{
                print(error)
                return nil
            }
            return morse
        }
    }
    
}
