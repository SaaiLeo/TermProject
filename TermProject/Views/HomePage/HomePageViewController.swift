//
//  HomePageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

var menus: [Menu] = []

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bestSellerCollectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    var categories: [MenuCategory] = []
    var bestSellers: [Menu] = []

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
    }
    
    private func registerCell() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        bestSellerCollectionView.register(UINib(nibName: MenuCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
    }
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case bestSellerCollectionView:
            return bestSellers.count
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
            let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
            
            scene.menu = bestSellers[indexPath.row]
            present(scene, animated: true)
            
        default:
            return
        }
    }
    
    
}
