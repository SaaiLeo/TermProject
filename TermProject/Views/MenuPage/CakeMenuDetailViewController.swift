//
//  CakeMenuDetailViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 9/9/24.
//

import UIKit

class CakeMenuDetailViewController: UIViewController {


    
    static let identifier = String(describing: CakeMenuDetailViewController.self)
    
    var onCartUpdated: (() -> Void)?
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var sweetnessLvl: String = ""
    var size: String = ""
    var quantity: Int = 1
    var totalPerCup: Double = 1.0
    var total: Double = 0.0
    
    var menu: Menu? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        footerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        guard let menu = menu else {return}
        menuImageView.image = UIImage(named: menu.image)
        nameLabel.text = menu.name
        
        totalPerCup = menu.sizePrice[0].price
        totalLabel.text = menu.price 

        calculateTotal()
        
        priceLabel.text = menu.price
    }
    
    private func calculateTotal() {
        total = totalPerCup * Double(quantity)
        priceLabel.text = String(format: "%.2f", totalPerCup)
        totalLabel.text = String(format: "%.2f", total)
    }

    
    @IBAction func quantityStepperClicked(_ sender: UIStepper) {
        quantity = Int(sender.value)
        quantityLabel.text = String(quantity)
        calculateTotal()
    }
    
    @IBAction func addToCartButtonClicked(_ sender: Any) {
        guard let menu = menu else {return}
        let order = Order(image: menu.image, name: menu.name, total: Double(String(format: "%.2f",self.total))!, sweetnessLvl: self.sweetnessLvl, size: self.size, quantity: self.quantity)
        self.dismiss(animated: true, completion: {
            CART.append(order)
            CartPageViewController().saveCartToUserDefaults()
            self.onCartUpdated?()
        })
    }
}
