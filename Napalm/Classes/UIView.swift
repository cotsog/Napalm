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
     Adds a boarder to the bottom of a UIView with the color and width passed in. The width is set with a default of 1.
     */
    public func addBottomBorder(withColor color: UIColor, andHeight height: CGFloat = 1) {
        let lineView = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 1.0, width: self.frame.size.width, height: height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    /**
     Adds a boarder to the top of a UIView with the color and height passed in. The height is set with a default of 1.
     */
    public func addTopBorder(withColor color: UIColor, andHeight height: CGFloat = 1) {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    /**
     Adds a boarder to the left of a UIView with the color and width passed in. The width is set with a default of 1.
     */
    public func addLeftBorder(withColor color: UIColor, andWidth width: CGFloat = 1) {
        let lineView = UIView(frame: CGRect(x: 1, y: 0, width: width, height: self.frame.size.height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    /**
     Adds a boarder to the bottom of a UIView with the color and width passed in. The width is set with a default of 1.
     */
    public func addRightBorder(withColor color: UIColor, andWidth width: CGFloat = 1) {
        let lineView = UIView(frame: CGRect(x: 1, y: 1, width: width, height: self.frame.size.height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    /**
     Animates the view to the set point on the Y axis with a duration of the CGPoint and TimeInterval passed in. The animation options can also be changed.
     
     **WARNING:** This function appears to be broken.
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
     Animates the view to the set point on the X axis with a duration of the CGPoint and TimeInterval passed in. The animation options can also be changed.
     
     **WARNING:** This function appears to be broken.
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
     Adds a gradient to the view going from the first color to the second color passed in. The depth, which is default to the back of the parent view, can be changed.
     
     **WARNING:** This function appears to be broken and only works on a UIViewControllers view.
     */
    public func addGradient(from topColor: UIColor, to bottomColor: UIColor, withDepth depth: UIViewDepth = .back) {
        let gradient = GradientView(tColor: topColor, bColor: bottomColor, frame: self.frame)
        self.addSubview(gradient)
        
        switch depth {
        case .back: self.sendSubview(toBack: gradient)
        case .front: break
        }
        
        
        
    }
}


