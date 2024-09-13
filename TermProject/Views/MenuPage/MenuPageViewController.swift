//
//  MenuPageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit

class MenuPageViewController: UIViewController {
    
    var menus: [Menu] = []
    
    static let identifier = String(describing: MenuPageViewController.self)
    
    @IBOutlet weak var collectionView: UICollectionView!

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
        
        if menus.isEmpty {
            menus = MENUS
        }
        registerCell()
    }
    
    private func registerCell() {
        collectionView.register(UINib(nibName: MenuCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
    }
    
    @objc func cartButtonClicked() {
        let scene = storyboard?.instantiateViewController(identifier: CartPageViewController.identifier) as! CartPageViewController
        
        navigationController?.pushViewController(scene, animated: true)
    }
    
    func cartAnimate() {
        navigationItem.rightBarButtonItem?.shakeAnimation()
    }
    
}

extension MenuPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        
        cell.setup(self.menus[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = self.menus[indexPath.row]
        
        switch item.category {
            
        case "coffee" :
            let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
            scene.onCartUpdated = {
                [weak self] in self?.cartAnimate()
            }
            scene.menu = self.menus[indexPath.row]
            present(scene, animated: true)
            
        case "drink" :
            let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
            scene.onCartUpdated = {
                [weak self] in self?.cartAnimate()
            }
            scene.menu = self.menus[indexPath.row]
            present(scene, animated: true)
            
        case "cake" :
            let scene = storyboard?.instantiateViewController(withIdentifier: CakeMenuDetailViewController.identifier) as! CakeMenuDetailViewController
            scene.onCartUpdated = {
                [weak self] in self?.cartAnimate()
            }
            scene.menu = self.menus[indexPath.row]
            present(scene, animated: true)
            
        case "icecream":
            let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
            scene.onCartUpdated = {
                [weak self] in self?.cartAnimate()
            }
            scene.menu = self.menus[indexPath.row]
            present(scene, animated: true)
            
        case "meal":
            let scene = storyboard?.instantiateViewController(withIdentifier: NonDrinkMenuDetailViewController.identifier) as! NonDrinkMenuDetailViewController
            scene.onCartUpdated = {
                [weak self] in self?.cartAnimate()
            }
            scene.menu = self.menus[indexPath.row]
            present(scene, animated: true)
            
        default:
            let scene = storyboard?.instantiateViewController(withIdentifier: MenuDetailViewController.identifier) as! MenuDetailViewController
            scene.menu = self.menus[indexPath.row]
            scene.onCartUpdated = {
                [weak self] in self?.cartAnimate()
            }
            present(scene, animated: true)
        }
        
    }
    
    
}
