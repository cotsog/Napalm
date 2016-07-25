//
//  Number.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import Foundation
import GameplayKit

public class NPFNumber {
    
    public init() {}
    
    /**
     Generates a random number between the Ints that are passed in.
     */
    public class func randomNumber(between lowNumber: Int, and highNumber: Int) -> Int {
        if #available(iOS 9.0, *) {
            let randomNumber = GKRandomSource.sharedRandom().nextInt(withUpperBound: highNumber - lowNumber) + lowNumber
            return randomNumber
        } else {
            let hNumber = UInt32(highNumber)
            let lNumber = UInt32(lowNumber)
            let random = arc4random_uniform(hNumber - lNumber) + lNumber
            let randomNumber = Int(random)
            return randomNumber
        }
        
    }
}
