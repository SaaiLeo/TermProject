//
//  CartPageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 10/9/24.
//

import UIKit
import Foundation

var CART: [Order] = []
var HISTORY: [OrderList] = []

class CartPageViewController: UIViewController, CALayerDelegate {
    
    static let identifier = String(describing: CartPageViewController.self)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var total = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
//        CART.append(Order(image:"french_fries", name: "French Fries", total: 3, sweetnessLvl: "", size: "Small", quantity: 3))
//        CART.append(Order(image:"french_fries", name: "French Fries", total: 2, sweetnessLvl: "", size: "Large", quantity: 2))
//        CART.append(Order(image:"french_fries", name: "French Fries", total: 1, sweetnessLvl: "", size: "Normal", quantity: 1))
//        
        calculateTotalInCart()
        totalLabel.text = "\(total)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        calculateTotalInCart()
        totalLabel.text = "\(total)"
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: CartItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CartItemTableViewCell.identifier)
    }
    
    private func calculateTotalInCart() {
        self.total = 0.0
        for i in CART {
            self.total += i.total
        }
    }
    
    @IBAction func orderButtonClicked (_ sender : UIButton) {
        let orderlist = OrderList(time: .now , total: self.total , orderList: CART)
        CART = []
        HISTORY.append(orderlist)
        tableView.reloadData()
        calculateTotalInCart()
        totalLabel.text = "\(total)"
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
        return 68
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the item from the data source
            CART.remove(at: indexPath.row)
            
            // Remove the row from the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            calculateTotalInCart()
            totalLabel.text = "\(total)"
        }
    }
    
    
}
