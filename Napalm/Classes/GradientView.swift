//
//  GradientView.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import Foundation

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
     */
    public init(tColor: UIColor, bColor: UIColor, frame: CGRect) {
        topColor = tColor
        bottomColor = bColor
        super.init(frame: frame)
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    /**
     Takes the colors that where passed in during intilization and draws a gradient on the view.
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
