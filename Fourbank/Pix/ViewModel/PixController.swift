//
//  PixController.swift
//  Fourbank
//
//  Created by Josicleison on 20/06/22.
//

import Foundation
import Alamofire

protocol PixController {
    
    func validatePixKey(_ key: String,
                        _ users: [User]) -> Bool
    func namesNdKeys(_ id: String,
                     _ users: [User]) -> ([String],[String])
}

extension PixController {
    
    func validatePixKey(_ key: String,
                        _ users: [User]) -> Bool {
        var result = false
                    
        for user in users {
            
            if user.emailPix == key ||
               user.cpfPix == key ||
               user.cellPhonePix == key ||
               user.randowKeyPix == key {
                
                result = true
            }
        }
        return result
    }
        
    func namesNdKeys(_ id: String,
                     _ users: [User]) -> ([String],[String]) {
         
        var names: [String] = []
        var pixKeys: [String] = []
        
        for user in users {
            
            if user.id != id {
                
                names.append(user.name)
                pixKeys.append(user.emailPix)
            }
        }
        return (names,pixKeys)
    }
}
