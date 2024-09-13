//
//  HomePageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Foundation


var MENUS: [Menu] = []

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bestSellerCollectionView: UICollectionView!

    @IBOutlet weak var usernameLabel: UILabel!

    @IBOutlet weak var trendingsCollectionView: UICollectionView!
    
    @IBOutlet weak var greetingMsgLabel: UILabel!
    
    
    var categories: [MenuCategory] = []
    var bestSellers: [Menu] = []
    var trendings: [Menu] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        button.setImage(cartImage, for: .normal)
        button.tintColor = #colorLiteral(red: 0.5215935111, green: 0.3794919848, blue: 0.2661398649, alpha: 1)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(cartButtonClicked), for: .touchUpInside)
         
         let barButtonItem = UIBarButtonItem(customView: button)
         self.navigationItem.rightBarButtonItem = barButtonItem
        
        categories.append(MenuCategory(id: "id0", image: "pokeball", title: "Near me"))
        categories.append(MenuCategory(id: "id1", image: "category_coffee", title: "coffee"))
        categories.append(MenuCategory(id: "id2", image: "category_cake", title: "cake"))
        categories.append(MenuCategory(id: "id3", image: "category_meal", title: "meal"))
        categories.append(MenuCategory(id: "id4", image: "category_icecream", title: "icecream"))
        categories.append(MenuCategory(id: "id5", image: "category_drink", title: "drink"))
        
        if let jsonFile = readJSONFile(named: "CoffeeShopMenu", withExtension: "json") {
            MENUS = jsonFile.menus
        }
        bestSellers = MENUS.filter{ $0.popularity == "bestSeller" }
        trendings = MENUS.filter{ $0.popularity == "trending" }
        registerCell()
        
        
        // change username according to logIn
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            let userId = user.uid
            
            db.collection("users").document(userId).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let name = data?["name"] as? String
                    self.usernameLabel.text = name
                } else {
                    print("Document does not exist")
                }
            }
        }

        greetingBasedOnTime(in: "Asia/Bangkok")
        
    }
    
    @objc func cartButtonClicked() {
        let scene = storyboard?.instantiateViewController(identifier: CartPageViewController.identifier) as! CartPageViewController
        
        navigationController?.pushViewController(scene, animated: true)
    }
    
    func cartAnimate() {
        navigationItem.rightBarButtonItem?.shakeAnimation()
    }
    
    private func registerCell() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        bestSellerCollectionView.register(UINib(nibName: MenuCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        trendingsCollectionView.register(UINib(nibName: MenuCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
    }
    
    private func greetingBasedOnTime(in timeZoneIdentifier: String) {
        // Get the current date and time
            let currentDate = Date()
            
            // Create a DateFormatter to extract the hour component
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH" // 24-hour format
            
            // Set to a specific time zone if provided
            if let timeZone = TimeZone(identifier: timeZoneIdentifier) {
                dateFormatter.timeZone = timeZone
            } else {
                dateFormatter.timeZone = TimeZone.current // Default to local time zone
            }
            
            // Set a locale to ensure consistent behavior
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            // Get the current hour as a string
            let hourString = dateFormatter.string(from: currentDate)
            
            // Safely convert the hour string to an integer
            guard let currentHour = Int(hourString) else {
                // Return a default value or handle the error as needed
                 print("Error determining time")
                return
            }
        var msg: String = ""
        // Determine the appropriate greeting based on the hour
            switch currentHour {
            case 0..<12:
                msg = "Good Morning,"
            case 12..<17:
                msg = "Good Afternoon,"
            case 17..<21:
                msg = "Good Evening,"
            default:
                msg = "Good Night,"
            }
        
        greetingMsgLabel.text = msg
    }
    
    // Function to read JSON file from the app bundle
    func readJSONFile(named fileName: String, withExtension fileExtension: String) -> Menus? {
        // Locate the file in the bundle
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            do {
                // Read the data from the file
                let data = try Data(contentsOf: fileURL)
                // Decode the data to the AppInfo struct
                let appInfo = try JSONDecoder().decode(Menus.self, from: data)
                return appInfo
            } catch {
                print("Error reading or decoding file: \(error.localizedDescription)")
            }
        } else {
            print("File not found.")
        }
        return nil
    }

}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case bestSellerCollectionView:
            return bestSellers.count
        case trendingsCollectionView:
            return trendings.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            
            cell.setup(categories[indexPath.row])
            return cell
            
        case bestSellerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
            
            cell.setup(bestSellers[indexPath.row])
            return cell
            
        case trendingsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
            
            cell.setup(trendings[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView{
        case categoryCollectionView:
            
            if categories[indexPath.row].title == "Near me" {
                let scene = storyboard?.instantiateViewController(identifier: MapPageViewController.identifier) as! MapPageViewController
                
                navigationController?.pushViewController(scene, animated: true)
            }else{
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuPageViewController.identifier) as! MenuPageViewController
                
                switch categories[indexPath.row].title {
                case "coffee":
                    scene.menus = MENUS.filter{ $0.category == "coffee"}
                case "drink":
                    scene.menus = MENUS.filter{ $0.category == "drink"}
                case "meal":
                    scene.menus = MENUS.filter{ $0.category == "meal"}
                case "cake":
                    scene.menus = MENUS.filter{ $0.category == "cake"}
                case "icecream":
                    scene.menus = MENUS.filter{ $0.category == "icecream"}
                default:
                    scene.menus = []
                }
                
                navigationController?.pushViewController(scene, animated: true)
            }
            
        case bestSellerCollectionView:
            
            let item = bestSellers[indexPath.row]
            
            switch item.category {
                
            case "coffee" :
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
                
            case "drink" :
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
                
            case "cake" :
                let scene = storyboard?.instantiateViewController(withIdentifier: CakeMenuDetailViewController.identifier) as! CakeMenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
                
            case "icecream":
                let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
                
            case "meal":
                let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
                
            default:
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
            }
            
        case trendingsCollectionView:
            
            let item = trendings[indexPath.row]
            
            switch item.category {
                
            case "coffee" :
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
                
            case "drink" :
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
                
            case "cake" :
                let scene = storyboard?.instantiateViewController(withIdentifier: CakeMenuDetailViewController.identifier) as! CakeMenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
                
            case "icecream":
                let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
                
            case "meal":
                let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
                
            default:
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.onCartUpdated = {
                    [weak self] in self?.cartAnimate()
                }
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
            }
            
        default:
            return
        }
    }
    
    
}
