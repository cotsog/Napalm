//
//  Networking.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/6/16.
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

//
//  Notes:
//
//  This class requires The APIClient file.
//

/**
 An easy interface for getting JSON data from a URL.
*/
public class NPFNetwork: APIClient {
    
    /**
     The configuration of the current session
     */
    public let configuration: URLSessionConfiguration
    
    /**
     The session used to get the data.
    */
    lazy public var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    /**
     The URL in String format where the data is going to be retrived from.
    */
    public let url: String
    
    /**
     Creates an instance of NPFNetwork.
     
     - parameter config: A URLSessionConfiguration.
     - parameter URL: The URL where the data is retrived from in String format.
     
     - returns: An instance of NPFNetwork for fetching data.
    */
    public init(config: URLSessionConfiguration, URL: String) {
        self.configuration = config
        self.url = URL
    }
    
    /**
     Creates an instance of NPFNetwork with the default session configuration.
     
     - parameter URL: The URL where the data is retrived from in String format.
     
     - returns: An instance of NPFNetwork for fetching data.
     */
    public convenience init(URL: String) {
        self.init(config: URLSessionConfiguration.default(), URL: URL)
    }
    
    /**
     A URLRequest object created from the url String property.
    */
    var request: URLRequest {
        let url = URL(string: self.url)
        return URLRequest(url: url!)
    }
    
    /**
     Gets JSON data from the url passed in during class initilization.
     
     - parameter completion: A closure of type (APIResult<T>) -> Void where you can get the data from the url request.
     - parameter key: The key in the JSON identifing where to get the data from in the JSON.
    */
    public func fetchData<T: JSONDecodable>(withCompletion completion: (APIResult<T>) -> Void, andJSONKey key: String) {
        
        fetch(request, parse: { json -> T? in
            // Parse from JSON response to CurrentWeather
            
            if let dataDictionary = json[key] as? [String : AnyObject] {
                return T(JSON: dataDictionary)
            } else {
                return nil
            }
            
            }, completion: completion)
    }
}
