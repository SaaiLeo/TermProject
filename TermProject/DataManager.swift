//
//  DataManager.swift
//  TermProject
//
//  Created by SaiThaw- on 27/9/2567 BE.
//

import Foundation
import Alamofire

class DataManager {
    static let shared = DataManager()
    
    var menus: [Menu] = []
    
    private init() {}
    
    func fetchMenus(completion: @escaping (Bool) -> Void) {
        AF.request("https://raw.githubusercontent.com/SaaiLeo/TermProject/main/TermProject/Models/CoffeeShopMenu.json").responseDecodable(of: Menus.self) { response in
            switch response.result {
            case .success(let menusData):
                self.menus = menusData.menus
                print("DataManager: Fetched Menus: \(self.menus.count)")
                completion(true)
            case .failure(let error):
                print("DataManager: Failed to fetch menus: \(error)")
                completion(false)
            }
        }
    }
}
