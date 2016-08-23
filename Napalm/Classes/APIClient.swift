//
//  APIClient.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/6/16.
//
//
//
// Copyright (c) 2016 Treehouse Island Inc. <help@teamtreehouse.com>
//
// Used with permission.


import Foundation

/**
 The error domain when there is an error from NSError.
*/
public let NPFNetworkingErrorDomain = "com.napalm.Napalm.NetworkingError"

/**
 The error used when there is no HTTP response.
*/
public let MissingHTTPResponseError: Int = 10

/**
 The error used when the HTTP response is not 200.
*/
public let UnexpectedResponseError: Int = 20

/**
 A typealias for data in a JSON format.
*/
public typealias JSON = [String : AnyObject]

/**
 A typealias for the data received after getting JSON data.
*/
public typealias JSONTaskCompletion = (JSON?, HTTPURLResponse?, NSError?) -> Void

/**
 A typealias for a getting data from a URL session.
*/
public typealias JSONTask = URLSessionDataTask

/**
 The resault of parsing the JSON worked.
*/
public enum APIResult<T> {
    case success(T)
    case failure(ErrorProtocol)
}

/**
 Used as a constraint for the generic types in the fetch and fetchData methods.
*/
public protocol JSONDecodable {
    init?(JSON: [String : AnyObject])
}

//public protocol Endpoint {
//    var baseURL: URL { get }
//    var path: String { get }
//    var request: URLRequest { get }
//}

/**
 Used to connect to the remote API to get JSON data.
*/
public protocol APIClient {
    var configuration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    /**
     Attempts to get the JSON data from a request.
     
     - parameter request: A URLRequest created from a URL to get the data from.
     - parameter completion: A closure with the JSON data, an HTTPURLResponse and an NSError.
     
     - returns: A URLSessionDataTask with the data if it is received.
     */
    func jsonTask(withRequest request: URLRequest, completion: JSONTaskCompletion) -> JSONTask
    
    /**
     Parses the JSON data from jsonTask and passes it to the completion.
     
     - parameter request: A URLRequest made from a URL.
     - parameter parse: A closure where the JSON data gets converted to the proper type.
     - parameter completion: A closure where the success case does depending on if the parsing works.
     */
    func fetch<T: JSONDecodable>(_ request: URLRequest, parse: (JSON) -> T?, completion: (APIResult<T>) -> Void)
}

extension APIClient {
    
    public func jsonTask(withRequest request: URLRequest, completion: JSONTaskCompletion) -> JSONTask {
        
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
        
        let task = jsonTask(withRequest: request) { json, response, error in
            
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
