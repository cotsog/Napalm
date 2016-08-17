//
//  Operators.swift
//  Pods
//
//  Created by Caleb Kleveter on 8/4/16.
//
//

import Foundation

postfix operator ^ {}

public postfix func ^<T: UIView>(view: T) {
    view.transform = CGAffineTransform(rotationAngle: 3.14)
}
