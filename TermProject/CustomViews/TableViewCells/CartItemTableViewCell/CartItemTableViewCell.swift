//
//  CartItemTableViewCell.swift
//  TermProject
//
//  Created by Sei Mouk on 10/9/24.
//

import UIKit


class CartItemTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CartItemTableViewCell.self)
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sweetnessLabel: UILabel!

    
    func setup(_ order: Order) {
        menuImageView.image = UIImage(named: order.image)
        nameLabel.text = order.name
        quantityLabel.text = "Qty: \(order.quantity)"
        costLabel.text = "THB " + String(order.total)
        sizeLabel.text = order.size
        sweetnessLabel.text = order.sweetnessLvl
    }
    
}
