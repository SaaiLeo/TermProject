//
//  ShopLocation.swift
//  TermProject
//
//  Created by Sei Mouk on 13/9/24.
//

import Foundation

struct ShopLocation: Codable {
    let name: String
    let openingHours: String
    let logo: String
    let LocationLat: Double
    let LocationLong: Double
}

struct ShopLocations: Codable {
    let ShopLocations: [ShopLocation]
    
}
