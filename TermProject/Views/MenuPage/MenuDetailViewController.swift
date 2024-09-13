//
//  MenuDetailViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 6/9/24.
//

import UIKit

class MenuDetailViewController: UIViewController {
    
    static let identifier = String(describing: MenuDetailViewController.self)
    
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
    var totalPerCup: Double = 0.0
    var total: Double = 0.0
    
    var menu: Menu? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        footerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        guard let menu = menu else {return}
        menuImageView.image = UIImage(named: menu.image)
        nameLabel.text = menu.name
        
        totalLabel.text = menu.price
        
        size = menu.sizePrice[0].size
        sweetnessLvl = "Zero"
        totalPerCup = menu.getPrice(forSize: size)
        calculateTotal()
        
        priceLabel.text = menu.price
    }
    
    private func calculateTotal() {
        total = totalPerCup * Double(quantity)
        priceLabel.text = String(format: "%.2f", totalPerCup)
        totalLabel.text = String(format: "%.2f", total)
    }
    
    @IBAction func sweetnessLvlClicked(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sweetnessLvl = "Zero"
        case 1:
            sweetnessLvl = "Less"
        case 2:
            sweetnessLvl = "Normal"
        case 3:
            sweetnessLvl = "Extra"
        default:
            sweetnessLvl = ""
        }
    }
    
    @IBAction func sizeClicked(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            size = "Small"
            totalPerCup = (menu?.getPrice(forSize: size))!
            calculateTotal()
        case 1:
            size = "Medium"
            totalPerCup = (menu?.getPrice(forSize: size))!
            calculateTotal()
        case 2:
            size = "Large"
            totalPerCup = (menu?.getPrice(forSize: size))!
            calculateTotal()
        case 3:
            size = "Extra Large"
            totalPerCup = (menu?.getPrice(forSize: size))!
            calculateTotal()
        default:
            size = ""
            totalPerCup = (menu?.getPrice(forSize: size))!
            calculateTotal()
        }
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
            self.onCartUpdated?()
        })
    }
    
}
