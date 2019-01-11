//
//  Data.swift
//  Morsing
//
//  Created by Paloma Bispo on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import Foundation

struct  Item: Codable {
    let text: String
    let morse: [Int]
    
    static func numbers() -> [Item]? {
        return getData(from: "NumbersData")
    }
    
    static func letters() -> [Item]? {
        return getData(from: "LettersData")
    }
    
    private static func getData(from resource: String) -> [Item]? {
        var items: [Item] = []
        guard let path = Bundle.main.path(forResource: resource, ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {return nil}
        
        do{
            items = try JSONDecoder().decode([Item].self, from: data)
        }catch{
            print(error)
        }
        return items
    }
    
    
}
