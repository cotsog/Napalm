//
//  Array.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import Foundation
import GameplayKit

public extension Array {
    
    /**
     Randomly selects a random item from an array and returns it.
     
     - return: An element that was randomly selected from the array.
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
     - returns: A randomly generated array of the type of Element.
     
     */
    public func randomArray(withLength length: Int) -> [Element] {
        var returnArray: [Element] = []
        var currentObject: Element
        
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


