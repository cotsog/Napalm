//
//  GradientView.swift
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

/**
 For giving UI elements gradients.
*/
class GradientView: UIView {
    
    /**
     The top color of the gradient that is drawn on the view.
     */
    let topColor: UIColor
    
    /**
     The bottom color of the gradient that is drawn on the view.
     */
    let bottomColor: UIColor
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Used to initilize the gradient colors and frame of the view.
     
     - parameter topColor: The color that is for the top of the gradient.
     - parameter bottomColor: The color that is for the bottom of the gradient.
     - parameter frame: A CGRect with the size and position of the gradient view.
    
     - return: A UIView with a gradient on it.
     */
    public init(topColor: UIColor, bottomColor: UIColor, frame: CGRect) {
        self.topColor = topColor
        self.bottomColor = bottomColor
        super.init(frame: frame)
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    /**
     Creates the gradient on the view.
     
     - parameter rect: The CGRect designating the size and position of the gradient.
     */
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        //// Gradient Declarations
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [topColor.cgColor, bottomColor.cgColor], locations: [0, 1])
        
        //// Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        context?.saveGState()
        backgroundPath.addClip()
        context?.drawLinearGradient(gradient!,
                                    start: CGPoint(x: 160, y: 0),
                                    end: CGPoint(x: 160, y: 568),
                                    options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        
    }
    
    
}
