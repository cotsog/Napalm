//
//  Number.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import Foundation
import GameplayKit

/**
 For doing math and querying numbers.
*/
public class NPFNumber {
    
    /**
     Generates a random number between two Ints.
     
     - parameter lowNumber: The bottom number of the range in which the random Int will be selected.
     - parameter highNumber: The top number of the range in which the random Int will be selected.
     
     - return: A random number selected between the top and bottom numbers.
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
    
    
    /**
     Converts a number in degrees to a number in raidians.
     
     - parameter degrees: A Double that is the number converted to raidians.
    
     - returns: A number in raidian form.
    */
    public class func convertToRadians(degrees: Double) -> Double {
       return  (degrees / 180) * Double.pi
    }
}