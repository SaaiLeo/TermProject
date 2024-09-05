//
//  CategoryCollectionViewCell.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: CategoryCollectionViewCell.self)

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLable: UILabel!
    
    
    func setup(_ category: MenuCategory) {
        categoryImageView.image = UIImage(named: category.image)
        categoryTitleLable.text = category.title
    }
}
