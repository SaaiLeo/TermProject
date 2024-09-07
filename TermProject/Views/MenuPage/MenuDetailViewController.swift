//
//  MenuDetailViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 6/9/24.
//

import UIKit

class MenuDetailViewController: UIViewController {
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var sweetnessLvl: String = ""
    var size: String = ""
    var quantity: Int = 1
    
    let menu: Menu? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let menu = menu else {return}
        menuImageView.image = UIImage(named: menu.image)
        nameLabel.text = menu.name
        priceLabel.text = menu.price

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
        case 1:
            size = "Medium"
        case 2:
            size = "Large"
        case 3:
            size = "Extra Large"
        default:
            size = ""
        }
    }
    
    @IBAction func quantityStepperClicked(_ sender: UIStepper) {
        quantity = Int(sender.value)
        quantityLabel.text = String(quantity)
    }
    
    @IBAction func addToCartButtonClicked(_ sender: Any) {
        print(sweetnessLvl, size, quantity)
    }
    
}
