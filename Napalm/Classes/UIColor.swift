//
//  UIColor.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//
//
//  Copyright (c) 2016 Caleb Kleveter
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import UIKit

public extension UIColor {
    
    /**
     Creates a UIColor.
     
     - parameter red: A CGFloat between 0 and 255 which defines how much red is in the color.
     - parameter green: A CGFloat between 0 and 255 which defines how much green is in the color.
     - parameter blue: A CGFloat between 0 and 255 which defines how much blue is in the color.
     - parameter alpha: A CGFloat between 0 and 1 which defines how much opacity is in the color.
    
     - returns: A UIColor defined by the values passed in.
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
     
     - returns: A UIColor defined by the values passed in.
     */
    public class func hsba(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> UIColor {
        
        return UIColor(hue: hue/360.0, saturation: saturation/100.0, brightness: brightness/100.0, alpha: alpha)
    }
    
    /**
     Extracts the red, green, blue, and alpha values from a UIColor.
     
     - returns: A tuple containing the individual values labeled red, green, blue and alpha.
    */
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        let didGetComponents = getRed(&r, green: &g, blue: &b, alpha: &a)
        return didGetComponents ? (r,g,b,a) : nil
    }
}
