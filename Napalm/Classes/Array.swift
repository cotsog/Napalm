//
//  Array.swift
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

public extension Array {
    
    /**
     Randomly selects a random item from an array and returns it.
     
     - returns: An element that was randomly selected from the array.
     */
    public func random() -> Element {
        if #available(iOS 9.0, *) {
            let randomNumber = GKRandomSource.sharedRandom().nextInt(withUpperBound: self.count)
            return self[randomNumber]
        } else {
            let arrayCount = UInt32(self.count)
            let random = arc4random_uniform(arrayCount)
            let randomNumber = Int(random)
            return self[randomNumber]
        }
    }
    
    /**
     Creates an Array with elements from the array this is called on.
     
     - parameter length: The length of the array returned.
     - parameter attribute: A value of type ArrayType that specifies if you want no repeating or duplicate elements in the array that is returned.
     - returns: A randomly generated array of the type of Element.
     
     */
    public func randomArray(withLength length: Int, andAttribute attribute: ArrayType? = nil) -> [Element] {
        var returnArray: [Element] = []
        var currentObject: Element
        
        if let attribute = attribute {
            if attribute == .noDuplicates {
                if self.count >= length {
                    
                    var parsingArray = self
                    while returnArray.count < length {
                        currentObject = parsingArray.random()
                        returnArray.append(currentObject)
                        parsingArray.remove(currentObject)
                    }
                } else {
                    fatalError("\n\(Date.init()) Napalm: - New array length is out of the bounds of the old array length.\n")
                }
            } else if attribute == .noRepeats {
        
                while returnArray.count < length {
                    if let lsObj = returnArray.last {
                        repeat {
                            currentObject = self.random()
                        } while "\(currentObject)" == "\(lsObj)"
                    } else {
                        currentObject = self.random()
                    }
                    returnArray.append(currentObject)
                }
            } else {
                fatalError("\n\(Date.init()) Napalm: - An unknown ArrayType case was passed in.\n")
            }
        } else {
            while returnArray.count < length {
                returnArray.append(self.random())
            }
        }
        return returnArray
    }
    
    /**
     Removes the object from an array that is passed in.
     
     - parameter object: The element that is removed from the array.
     */
    public mutating func remove(_ object: Element) {
        var array: [String] = []
        for i in self {
            array.append("\(i)")
        }
        let item = array.index(of: "\(object)")
        if let obj = item {
            self.remove(at: obj)
        }
    }
}

/**
 Used for specifying the attributes of an array with the randomArray method.
*/
public enum ArrayType {
    /**
     For when you don't want an element used in the array more then once.
    */
    case noDuplicates
    
    /**
     For when you don't want an element used more then once in a row in an array. (It can still appear more then once)
    */
    case noRepeats
}















