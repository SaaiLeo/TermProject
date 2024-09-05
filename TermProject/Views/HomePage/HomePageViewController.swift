//
//  HomePageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bestSellerCollectionView: UICollectionView!
    
    var categories: [MenuCategory] = []
    
    var menus: [Menu] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Coffee"))
        categories.append(MenuCategory(id: "id2", image: "cappuccino", title: "Coffee2"))
        categories.append(MenuCategory(id: "id2", image: "cappuccino", title: "Coffee3"))
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Coffee4"))
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Coffee5"))
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Coffee6"))
        
        menus.append(Menu(name: "Cuppuccino", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "bestSeller"))
        menus.append(Menu(name: "Cuppuccino2", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "bestSeller"))
        menus.append(Menu(name: "Cuppuccino3", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "bestSeller"))
        menus.append(Menu(name: "Cuppuccino4", price: "$3.99", image: "cappuccino", category: "coffee", popularity: "bestSeller"))
        
        registerCell()
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
            return menus.count
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
            
            cell.setup(menus[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }

    }
    
    
}
