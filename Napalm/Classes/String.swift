//
//  String.swift
//  Pods
//
//  Created by Caleb Kleveter on 8/31/16.
//
//

import Foundation

public extension String {    
    public var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = Predicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: self) == false {
            return false
        } else {
            return true
        }
    }
}
