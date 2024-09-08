//
//  UIView+Extension.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {return self.cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
