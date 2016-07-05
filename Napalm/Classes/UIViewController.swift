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
     Presents a UIAlertController with the title, message and button title passed in. The button title has a default value of "OK".
     */
    public func userErrorAlert(_ title: String, message: String?, buttonTitle: String = "OK") {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    /**
     Presents a UIAlertController with the title and message passed in. The alert has two buttons, one dissmises the alert controller and the other fires the function that is passed in.
     */
    public func optionAlert(_ title: String, message: String?, cancelButtonTitle: String, actionButtonTitle: String, handler: (UIAlertAction) -> Void) {
        
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        errorAlert.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: handler))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
}
