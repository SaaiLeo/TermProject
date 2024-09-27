//
//  MenuCategory.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import Foundation

struct MenuCategory: Codable {
    let id: String
    let image: String
    let title: String
}

struct Categories: Codable {
    let categories: [MenuCategory]
}
