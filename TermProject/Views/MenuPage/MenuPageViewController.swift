//
//  MenuPageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit

class MenuPageViewController: UIViewController {
    
    static let identifier = String(describing: MenuPageViewController.self)
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: MenuCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
    }
}

extension MenuPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        
        cell.setup(menus[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = menus[indexPath.row]
        
        switch item.category {
            
        case "coffee" :
            let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
            scene.menu = menus[indexPath.row]
            present(scene, animated: true)
            
        case "drink" :
            let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
            scene.menu = menus[indexPath.row]
            present(scene, animated: true)
            
        case "cake" :
            let scene = storyboard?.instantiateViewController(withIdentifier: CakeMenuDetailViewController.identifier) as! CakeMenuDetailViewController
            scene.menu = menus[indexPath.row]
            present(scene, animated: true)
            
        case "snack":
            let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
            scene.menu = menus[indexPath.row]
            present(scene, animated: true)
            
        case "food":
            let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
            scene.menu = menus[indexPath.row]
            present(scene, animated: true)
            
        default:
            let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
            scene.menu = menus[indexPath.row]
            present(scene, animated: true)
        }
        
    }
    
    
}
