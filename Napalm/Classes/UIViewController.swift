//
//  UIViewController.swift
//  Pods
//
//  Created by Caleb Kleveter on 7/5/16.
//
//

import Foundation
import UIKit

public extension UIViewController {
    
    /**
     Presents a UIAlertController with a title, message and a button to dismiss the controller.
     
     - parameter title: The title of the UIAlerController.
     - parameter message: An optional String for the UIAlertController's message.
     - parameter buttonTitle: The title of the dismiss button: Defaults to "OK".
     */
    public func userErrorAlert(title: String, message: String?, buttonTitle: String = "OK") {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    /**
     Presents a UIAlertController with a title, message, a button to dismiss the controller, a button to perform an action and a handler that gets fired when the action button is pressed.
     
     - parameter title: The title of the UIAlerController.
     - parameter message: An optional String for the UIAlertController's message.
     - parameter cancelButtonTitle: The title of the dismiss button.
     - parameter actionButtonTitle: The title of the button the fires the handler.
     - parameter handler: The function that gets fired when the actionButton gets pressed.
     */
    public func optionAlert(title: String, message: String?, cancelButtonTitle: String, actionButtonTitle: String, handler: (UIAlertAction) -> Void) {
        
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        errorAlert.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: handler))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
}
