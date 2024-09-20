//
//  Order.swift
//  TermProject
//
//  Created by Sei Mouk on 7/9/24.
//

import Foundation

struct Order: Codable{
    let image: String
    let name: String
    let total: Double
    let sweetnessLvl: String
    let size: String
    let quantity: Int
}

struct OrderList: Codable {
    let time: Date
    let total: Double
    let orderList: [Order]
}
