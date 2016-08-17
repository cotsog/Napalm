//
//  UIImageView.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import Foundation
import UIKit

public extension UIImageView {
    
    /**
     Initilizes a UIImageView's animation properties.
     
     - parameter images: The array of images that is used for the animation.
     - parameter repeatCount: The amount of times the animation is run.
     - parameter duration: How long the animation takes in seconds.
     */
    public func imageAnimation(images: [UIImage], repeatCount: Int, duration: Double) {
        self.animationImages = images
        self.animationRepeatCount = repeatCount
        self.animationDuration = duration
    }
    
    /**
     Adds a sub-view to the UIImageView to blur it.
     
     **WARNING:** This function appears to be broken.
     */
    public func blurImage() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.frame
        self.addSubview(blurView)
    }
}
