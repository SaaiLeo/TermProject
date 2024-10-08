//
//  shakeAnimation.swift
//  TermProject
//
//  Created by Sei Mouk on 13/9/24.
//

import UIKit

extension UIBarButtonItem {
    
    func shakeAnimation() {
        guard let customView = self.customView else {return}
        
        // Reset the transform to ensure we start from the current state
        customView.transform = .identity

        // Define the shake animation
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.values = [-10, 10, -10, 10, -10, 0]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.duration = 0.5

        // Apply the animation to the custom view's layer
        customView.layer.add(animation, forKey: "shake")
    }
    
    func rotateAnimation() {
        guard let customView = self.customView else { return }

        // Reset the transform to ensure we start from the current state
        customView.transform = .identity

        // Define the rotation animation
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        let angle: CGFloat = 25 * (.pi / 180)  // 25 degrees to radians

            animation.values = [
                -angle,  // -25 degrees
                angle,   // 25 degrees
                -angle,  // -25 degrees
                angle,   // 25 degrees
                -angle,  // -25 degrees
                0        // back to original position
            ]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.duration = 0.5

        // Apply the animation to the custom view's layer
        customView.layer.add(animation, forKey: "rotate")
    }

}
