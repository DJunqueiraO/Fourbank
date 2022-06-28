//
//  Alert.swift
//  Fourbank
//
//  Created by Pedro Moraes (user220265) on 6/13/22.
//

import UIKit

extension UIViewController {
    
    func alert(messageTitle: String, message: String, buttonTitle: String) {
        
        let alert = UIAlertController(title: messageTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        present(alert, animated: true, completion: nil)
    }
}
