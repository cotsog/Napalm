//
//  UIColor.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import Foundation
import UIKit

public extension UIColor {
    
    /**
     Creates a UIColor.
     
     - parameter red: A CGFloat between 0 and 255 which defines how much red is in the color.
     - parameter green: A CGFloat between 0 and 255 which defines how much green is in the color.
     - parameter blue: A CGFloat between 0 and 255 which defines how much blue is in the color.
     - parameter alpha: A CGFloat between 0 and 1 which defines how much opacity is in the color.
    
     Return: A UIColor defined by the values passed in.
     */
    public class func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    /**
     Creates a UIColor.
     
     - parameter hue: A CGFloat between 0 and 360 which defines how much hue is in the color.
     - parameter saturation: A CGFloat between 0 and 100 which defines how saturated the color is.
     - parameter brightness: A CGFloat between 0 and 100 which defines how bright the color is.
     - parameter alpha: A CGFloat between 0 and 1 which defines how much opacity is in the color.
     
     Return: A UIColor defined by the values passed in.
     */
    public class func hsba(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> UIColor {
        
        return UIColor(hue: hue/360.0, saturation: saturation/100.0, brightness: brightness/100.0, alpha: alpha)
    }
}
