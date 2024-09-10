//
//  CartPageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 10/9/24.
//

import UIKit

var CART: [Order] = []

class CartPageViewController: UIViewController {
    
    static let identifier = String(describing: CartPageViewController.self)
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        CART.append(Order(image:"french_fries", name: "French Fries", total: 3.99, sweetnessLvl: "", size: "Small", quantity: 3))
        CART.append(Order(image:"french_fries", name: "French Fries", total: 3.99, sweetnessLvl: "", size: "Large", quantity: 2))
        CART.append(Order(image:"french_fries", name: "French Fries", total: 3.99, sweetnessLvl: "", size: "Normal", quantity: 1))
        
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: CartItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CartItemTableViewCell.identifier)
    }
}

extension CartPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CART.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.identifier) as! CartItemTableViewCell
        
        cell.setup(CART[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
}
