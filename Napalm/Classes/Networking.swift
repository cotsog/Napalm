//
//  Networking.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/6/16.
//
//

import Foundation

/**
 An easy interface for getting JSON data from a URL.
*/
public class NPFNetwork: APIClient {
    
    public let configuration: URLSessionConfiguration
    
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
     
     Return: An instance of NPFNetwork for fetching data.
    */
    public init(config: URLSessionConfiguration, URL: String) {
        self.configuration = config
        self.url = URL
    }
    
    /**
     Creates an instance of NPFNetwork with the default session configuration.
     
     - parameter URL: The URL where the data is retrived from in String format.
     
     Return: An instance of NPFNetwork for fetching data.
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
