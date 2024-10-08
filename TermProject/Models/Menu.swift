//
//  Menu.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import Foundation

struct Menu : Codable {
    let name: String
    let price: String
    let image: String
    let category: String
    let popularity: String
    let sizePrice: [SizePrice]
    
    func getPrice(forSize size: String) -> Double {
        return sizePrice.first(where: { $0.size == size })!.price
    }
}


struct SizePrice: Codable {
    let size: String
    let price: Double
}

struct Menus : Codable {
    let menus: [Menu]
}
