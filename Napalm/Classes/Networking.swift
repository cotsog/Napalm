//
//  Networking.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/6/16.
//
//

import Foundation

public protocol JSONInitable {
    init?(JSON: [String : AnyObject])
}

public class NPFNetwork: APIClient {
    
    let configuration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    public let url: String
    
    init(config: URLSessionConfiguration, URL: String) {
        self.configuration = config
        self.url = URL
    }
    
    convenience init(URL: String) {
        self.init(config: URLSessionConfiguration.default(), URL: URL)
    }
    
    var request: URLRequest {
        let url = URL(string: self.url)
        return URLRequest(url: url!)
    }
    
    func fetchData<T: JSONInitable>(withCompletion completion: (APIResult<T>) -> Void) {
        
        fetch(request, parse: { json -> T? in
            // Parse from JSON response to CurrentWeather
            
            if let currentWeatherDictionary = json["currently"] as? [String : AnyObject] {
                return T(JSON: currentWeatherDictionary)
            } else {
                return nil
            }
            
            }, completion: completion)
    }
}
