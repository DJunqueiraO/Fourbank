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
    
    func finalAlert(_ messageTitle: String,
                    _ message: String,
                    _ buttonTitle: String,
                    _ goToLocale: UIViewController) {
        
        let alert = UIAlertController(title: messageTitle, message: message, preferredStyle: .alert)
        goToLocale.modalPresentationStyle = .fullScreen
        
        let alertAction = UIAlertAction(title: buttonTitle, style: .default){action in
            
            self.present(goToLocale, animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}
