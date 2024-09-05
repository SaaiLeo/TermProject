//
//  MenuCollectionViewCell.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: MenuCollectionViewCell.self)
    
   // @IBOutlet weak var heartIcon: UIImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var footerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        footerView.backgroundColor =  UIColor.black.withAlphaComponent(0.5)
    }
    
    
    func setup(_ menu: Menu){
        nameLabel.text = menu.name
        priceLabel.text = menu.price
        menuImage.image = UIImage(named: menu.image)
    }
    
    

}
