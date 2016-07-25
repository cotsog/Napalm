//
//  Networking.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/6/16.
//
//

import Foundation

public class NPFNetwork: APIClient {
    
    public let configuration: URLSessionConfiguration
    lazy public var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    public let url: String
    
    public init(config: URLSessionConfiguration, URL: String) {
        self.configuration = config
        self.url = URL
    }
    
    public convenience init(URL: String) {
        self.init(config: URLSessionConfiguration.default(), URL: URL)
    }
    
    var request: URLRequest {
        let url = URL(string: self.url)
        return URLRequest(url: url!)
    }
    
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
