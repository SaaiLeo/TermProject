//
//  HomePageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categories: [MenuCategory] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "App name"
        
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Coffee"))
        categories.append(MenuCategory(id: "id2", image: "cappuccino", title: "Coffee2"))
        categories.append(MenuCategory(id: "id2", image: "cappuccino", title: "Coffee3"))
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Coffee4"))
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Coffee5"))
        categories.append(MenuCategory(id: "id1", image: "cappuccino", title: "Coffee6"))
        
        registerCell()
    }
    
    private func registerCell() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        
        cell.setup(categories[indexPath.row])
        
        return cell
    }
    
    
}
