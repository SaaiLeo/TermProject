//
//  HomePageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit
import Foundation

var menus: [Menu] = []

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bestSellerCollectionView: UICollectionView!
    @IBOutlet weak var trendingsCollectionView: UICollectionView!
    
    @IBOutlet weak var greetingMsgLabel: UILabel!
    

    
    var categories: [MenuCategory] = []
    var bestSellers: [Menu] = []
    var trendings: [Menu] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Coffee"))
        categories.append(MenuCategory(id: "id2", image: "cupcake", title: "Cake"))
        categories.append(MenuCategory(id: "id2", image: "cappuccino", title: "Food"))
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Snack"))
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Drink"))
        
        menus.append(Menu(name: "Cuppuccino", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "bestSeller", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "Brownie Cupcake", price: "$1.99", image: "cupcake", category: "cake", popularity: "bestSeller", sizePrice: [SizePrice(size: "Normal", price: 1.99)]))
        menus.append(Menu(name: "Orange", price: "$3.99", image: "orange_juice", category: "drink", popularity: "bestSeller", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "Caesar Salad", price: "$3.99", image: "caesar_salad", category: "food", popularity: "bestSeller", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "French Fries", price: "$3.99", image: "french_fries", category: "snack", popularity: "bestSeller", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "Cuppuccino4", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "trending", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "Cuppuccino4", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "trending", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "Cuppuccino4", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "trending", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "Cuppuccino4", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "trending", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "Cuppuccino4", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "trending", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "Cuppuccino4", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "trending", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "Cuppuccino4", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "trending", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        menus.append(Menu(name: "Cuppuccino4", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "trending", sizePrice: [SizePrice(size: "Small", price: 3.99), SizePrice(size: "Medium", price: 4.99), SizePrice(size: "Large", price: 5.99), SizePrice(size: "Extra Large", price: 6.99)]))
        
        bestSellers = menus.filter{ $0.popularity == "bestSeller" }
        trendings = menus.filter{ $0.popularity == "trending" }
        registerCell()
        greetingBasedOnTime(in: "Asia/Bangkok")
        
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
            print("Hour String: \(hourString)") // Debug print
            
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
            let scene = storyboard?.instantiateViewController(withIdentifier: MenuPageViewController.identifier) as! MenuPageViewController
            
            scene.modalPresentationStyle = .fullScreen
            present(scene, animated: true)
            
        case bestSellerCollectionView:
            
            let item = bestSellers[indexPath.row]
            
            switch item.category {
                
            case "coffee" :
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
                
            case "drink" :
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
                
            case "cake" :
                let scene = storyboard?.instantiateViewController(withIdentifier: CakeMenuDetailViewController.identifier) as! CakeMenuDetailViewController
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
                
            case "snack":
                let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
                
            case "food":
                let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
                
            default:
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.menu = bestSellers[indexPath.row]
                present(scene, animated: true)
            }
            
        case trendingsCollectionView:
            
            let item = trendings[indexPath.row]
            
            switch item.category {
                
            case "coffee" :
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
                
            case "drink" :
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
                
            case "cake" :
                let scene = storyboard?.instantiateViewController(withIdentifier: CakeMenuDetailViewController.identifier) as! CakeMenuDetailViewController
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
                
            case "snack":
                let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
                
            case "food":
                let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
                
            default:
                let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
                scene.menu = trendings[indexPath.row]
                present(scene, animated: true)
            }
            
        default:
            return
        }
    }
    
    
}
