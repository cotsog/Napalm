//
//  Location.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import CoreLocation
import Foundation

/**
 Get information about a devices current location.
*/
public class NPFLocation: NSObject, CLLocationManagerDelegate {
    
    /**
     Used in the getPermissionFromUser method for when the app needs permission to get the location of the device.
    */
    public enum GetAppLocation {
        case whenInUse
        case always
    }
    
    
    /**
     The location manager to get the devices location.
    */
    var locationManager: CLLocationManager
    
    
    /**
     Creates an instance of NPFLocation with a location manager. The location manager delegate is also assigned.
     
     - parameter locationManger: Used in getting the devices location.
     
     - return: An instance of NPFLocation with a location manager.
    */
    public init (locationManger: CLLocationManager) {
        self.locationManager = locationManger
        super.init()
        locationManager.delegate = self
        
    }
    
    /**
     Requests permission from the user to get the devices location *if* not already set.
     
     - parameter duringTime: When the app is allowed to get the devices location, whether always or only when in use.
    */
    public func getPermissionFromUser(duringTime: GetAppLocation) {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            switch duringTime {
            case .whenInUse: locationManager.requestWhenInUseAuthorization()
            case .always: locationManager.requestAlwaysAuthorization()
            }
        }
    }
    
    /**
     Gets the devices coordinates.
     
     - returns: A tuple of optional floats. (latitude: Float?, longitude: Float?).
    */
    public func coordinate() -> (latitude: Float?, longitude: Float?) {
        guard let lat = locationManager.location?.coordinate.latitude,
            let long = locationManager.location?.coordinate.longitude else {
                return (latitude: nil, longitude: nil)
        }
        
        let latitude = lat
        let longitude = long
        
        return (latitude: Float(latitude), longitude: Float(longitude))
    }
    
    /**
     Gets the city the device is in. Returns "N/A" if there is an error getting the city.
     
     - returns: A String with the city's name.
    */
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
    
    /**
     Gets the country the device is in. Returns "N/A" if there is an error getting the country.
     
     - returns: A String with the country's name.
     */
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
    
    /**
     Gets the zip code the device is in. Returns nil if there is an error getting the zip code.
     
     - returns: An optional Int with the zip code name.
     */
    public func getZip() -> Int? {
        var returnZip: Int? = nil
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
    
    /**
     Gets the location the device is in (i.e. Apple Store). Returns "N/A" if there is an error getting the location name.
     
     - returns: A String with the location name.
     */
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
    
    /**
     Gets the street the device is on. Returns "N/A" if there is an error getting the street.
     
     - returns: A String with the street name.
     */
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




