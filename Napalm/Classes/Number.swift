//
//  Number.swift
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
