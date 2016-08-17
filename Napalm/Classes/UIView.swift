//
//  UIView.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import Foundation
import UIKit

public extension UIView {
    
    /**
     This enum is used to set the depth value of the GradientView for the addGradient function.
     */
    public enum UIViewDepth {
        case front
        case back
    }
    
    /**
     Adds a boarder to the bottom of a UIView.
     
     - parameter color: A UIColor setting the color of the boarder.
     - parameter height: The height of the boarder in pixels. Default is set to 1.
     */
    public func addBottomBorder(withColor color: UIColor, andHeight height: CGFloat = 1) {
        let lineView = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 1.0, width: self.frame.size.width, height: height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    /**
     Adds a boarder to the top of a UIView.
     
     - parameter color: A UIColor setting the color of the boarder.
     - parameter height: The height of the boarder in pixels. Default is set to 1.
     */
    public func addTopBorder(withColor color: UIColor, andHeight height: CGFloat = 1) {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    /**
     Adds a boarder to the left of a UIView.
     
     - parameter color: A UIColor setting the color of the boarder.
     - parameter height: The height of the boarder in pixels. Default is set to 1.
     */
    public func addLeftBorder(withColor color: UIColor, andWidth width: CGFloat = 1) {
        let lineView = UIView(frame: CGRect(x: 1, y: 0, width: width, height: self.frame.size.height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    /**
     Adds a boarder to the bottom of a UIView.
     
     - parameter color: A UIColor setting the color of the boarder.
     - parameter height: The height of the boarder in pixels. Default is set to 1.
     */
    public func addRightBorder(withColor color: UIColor, andWidth width: CGFloat = 1) {
        let lineView = UIView(frame: CGRect(x: 1, y: 1, width: width, height: self.frame.size.height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    /**
     Animates the view to the set point on the Y axis.
     
     **WARNING:** This function appears to be broken.
     
     - parameter origin: The point on the Y axis that the view is animated to.
     - parameter duration: How long the animation takes in seconds.
     - parameter option: Any UIViewAnimationOption to change the way the animation runs.
     */
    func toggleViewOnY(to origin: CGFloat, withDuration duration: TimeInterval, andOptions option: UIViewAnimationOptions = UIViewAnimationOptions()) {
        var menuFrame = self.frame
        menuFrame.origin.y = origin
        
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: option,
                       animations: { () -> Void in
                        self.frame = menuFrame
            }, completion: { _ in })
    }
    
    /**
     Animates the view to the set point on the X axis.
     
     **WARNING:** This function appears to be broken.
     
     - parameter origin: The point on the X axis that the view is animated to.
     - parameter duration: How long the animation takes in seconds.
     - parameter option: Any UIViewAnimationOption to change the way the animation runs.
     */
    func toggleViewOnX(to origin: CGFloat, withDuration duration: TimeInterval, andOptions option: UIViewAnimationOptions = UIViewAnimationOptions()) {
        var menuFrame = self.frame
        menuFrame.origin.x = origin
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: option,
                       animations: { () -> Void in
                        self.frame = menuFrame
            }, completion: { _ in })
    }
    
    /**
     Adds a gradient to the UIView.
     
     **WARNING:** This function appears to be broken and only works on a UIViewControllers view.
     
     - parameter topColor: The color that is for the top of the gradient.
     - parameter bottomColor: The color that is for the bottom of the gradient.
     - parameter depth: Whether the view gets sent to the back of the parent view or not. Default value is `.back`.
     */
    public func addGradient(from topColor: UIColor, to bottomColor: UIColor, withDepth depth: UIViewDepth = .back) {
        let gradient = GradientView(topColor: topColor, bottomColor: bottomColor, frame: self.frame)
        self.addSubview(gradient)
        
        switch depth {
        case .back: self.sendSubview(toBack: gradient)
        case .front: break
        }
        
        
        
    }
}

