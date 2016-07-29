//
//  APIClient.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/6/16.
//
//

import Foundation

public let NPFNetworkingErrorDomain = "com.napalm.Napalm.NetworkingError"
public let MissingHTTPResponseError: Int = 10
public let UnexpectedResponseError: Int = 20

public typealias JSON = [String : AnyObject]
public typealias JSONTaskCompletion = (JSON?, HTTPURLResponse?, NSError?) -> Void
public typealias JSONTask = URLSessionDataTask

public enum APIResult<T> {
    case success(T)
    case failure(ErrorProtocol)
}

public protocol JSONDecodable {
    init?(JSON: [String : AnyObject])
}

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

public protocol APIClient {
    var configuration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWithRequest(_ request: URLRequest, completion: JSONTaskCompletion) -> JSONTask
    func fetch<T: JSONDecodable>(_ request: URLRequest, parse: (JSON) -> T?, completion: (APIResult<T>) -> Void)
}

extension APIClient {
    
    public func JSONTaskWithRequest(_ request: URLRequest, completion: JSONTaskCompletion) -> JSONTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                
                let error = NSError(domain: NPFNetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error)
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                        completion(json, HTTPResponse, nil)
                    } catch let error as NSError {
                        completion(nil, HTTPResponse, error)
                    }
                default: print("Received HTTP Response: \(HTTPResponse.statusCode) - not handled")
                }
            }
        }
        
        return task
    }
    
    public func fetch<T>(_ request: URLRequest, parse: (JSON) -> T?, completion: (APIResult<T>) -> Void) {
        
        let task = JSONTaskWithRequest(request) { json, response, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        // TODO: Implement Error Handling
                    }
                    return
                }
                
                if let value = parse(json) {
                    completion(.success(value))
                } else {
                    let error = NSError(domain: NPFNetworkingErrorDomain, code: UnexpectedResponseError, userInfo: nil)
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
