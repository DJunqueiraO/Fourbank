//
//  PixRegisterViewModel.swift
//  Fourbank
//
//  Created by Josicleison on 22/06/22.
//

import Foundation
import Alamofire
import UIKit

class PixRegisterViewModel: UIViewController {
    
    func randomPixKeyGeneratorAPI(_ id: String,
                                  _ users: [User]) -> [String: Any] {
    var newRandowKey = ""

        repeat {

            newRandowKey = String(Int.random(in: 0...100))
            for user in users {
                
                if user.randowKeyPix == newRandowKey {
                    newRandowKey = ""
                }
            }
        } while newRandowKey == ""

        return ["randowKeyPix": newRandowKey]
    }
    
    func registerPix(_ id: String,
                     _ key: String,
                     _ users: [User]) -> [String: Any]? {
                    
        if self.validateEmail(key) {
            
            for user in users {
                
                if user.emailPix == key {
                    
                    return nil
                }
            }
            return ["emailPix":key]
        }
        else if self.validateCellPhone(key) {
            
            for user in users {
                
                if user.emailPix == key {
                    
                    return nil
                }
            }
            return ["cellphonePix":key]
        }
        else if self.validateCPF(key) {
            
            for user in users {
                
                if user.emailPix == key {
                    
                    return nil
                }
            }
            return ["cpfPix":key]
        }
        else {
            
            return nil
        }
    }
}
