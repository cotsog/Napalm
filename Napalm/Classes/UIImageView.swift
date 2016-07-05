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
     Takes in an Array of UIImages, an Int and a Double and creates an image based animation for the image view.
     */
    public func imageAnimation(_ images: [UIImage], repeatCount: Int, duration: Double) {
        self.animationImages = images
        self.animationRepeatCount = repeatCount
        self.animationDuration = duration
    }
    
    /**
     Adds a sub-view of the image to blur it.
     
     **WARNING:** This function appears to be broken.
     */
    public func blurImage() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.frame
        self.addSubview(blurView)
    }
}
