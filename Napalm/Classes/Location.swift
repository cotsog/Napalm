//
//  Location.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import CoreLocation
import Foundation

public class NPFLocation: NSObject, CLLocationManagerDelegate {
    
    public enum GetAppLocation {
        case whenInUse
        case always
    }
    
    var locationManager: CLLocationManager
    
    public init (locationManger: CLLocationManager) {
        self.locationManager = locationManger
        super.init()
        locationManager.delegate = self
        
    }
    
    public func getPermissionFromUser(duringTime: GetAppLocation) {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            switch duringTime {
            case .whenInUse: locationManager.requestWhenInUseAuthorization()
            case .always: locationManager.requestAlwaysAuthorization()
            }
        }
    }
    
    public func coordinate() -> (latitude: Float?, longitude: Float?) {
        guard let lat = locationManager.location?.coordinate.latitude,
            let long = locationManager.location?.coordinate.longitude else {
                return (latitude: nil, longitude: nil)
        }
        
        let latitude = lat
        let longitude = long
        
        return (latitude: Float(latitude), longitude: Float(longitude))
    }
    
    public func getCity() -> String {
        var returnCity: String = "N/A"
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            // City
            if let city = placeMark.addressDictionary!["City"] as? String {
                returnCity = city
            }
        })
        return returnCity
    }
    
    public func getCountry() -> String {
        var returnCountry: String = "N/A"
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            // City
            if let country = placeMark.addressDictionary!["Country"] as? String {
                returnCountry = country
            }
        })
        return returnCountry
    }
    
    public func getZip() -> Int {
        var returnZip: Int = 0
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            // City
            if let zip = placeMark.addressDictionary!["ZIP"] as? Int {
                returnZip = zip
            }
        })
        return returnZip
    }
    
    public func getLocationName() -> String {
        var returnName: String = "N/A"
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            // City
            if let locationName = placeMark.addressDictionary!["Name"] as? String {
                returnName = locationName
            }
        })
        return returnName
    }
    
    public func getStreetAddress() -> String {
        var returnAddress: String = "N/A"
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            // City
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? String {
                returnAddress = street
            }
        })
        return returnAddress
    }
    
}




