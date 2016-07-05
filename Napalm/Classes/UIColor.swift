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
     Creates and returns a UIColor from the CGFloats passed in. The numbers are devided automaticlly, so there is no need to use decimals or number/255 (alpha is still a decimal value).
     */
    public class func rgba(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    /**
     Creates and returns a UIColor from the CGFloats passed in. The numbers are devided automaticlly, so there is no need to use decimals or number/360 and number/100 (alpha is still a decimal value).
     */
    public class func hsba(_ hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> UIColor {
        
        return UIColor(hue: hue/360.0, saturation: saturation/100.0, brightness: brightness/100.0, alpha: alpha)
    }
}
