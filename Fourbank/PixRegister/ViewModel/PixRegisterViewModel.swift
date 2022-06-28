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
                                  _ users: [User]) {
    var newRandowKey = ""

        repeat {

            newRandowKey = String(Int.random(in: 0...100))
            for user in users {
                
                if user.randowKeyPix == newRandowKey {
                    newRandowKey = ""
                }
            }
        } while newRandowKey == ""

        let parameter: [String: Any] = ["randowKeyPix": newRandowKey]

        AF.request("https://62baed237bdbe01d52938975.mockapi.io/api/users/\(id)",
                   method: .put,
                   parameters: parameter,
                   encoding: JSONEncoding.default).responseJSON {response in
            
            self.alert(messageTitle: "Sucesso!",
                            message: "Sua Chave foi cadastrada com sucesso",
                            buttonTitle: "Ok")
            print("success")
        }
    }
    
    func registerPix(_ id: String,
                     _ key: String,
                     _ users: [User]) {
        var parameter = ["":""]
                    
        if self.validateEmail(key) {
            
            parameter = ["emailPix":key]
            
            for user in users {
                
                if user.emailPix == key {
                    
                    parameter = ["":""]
                }
            }
        }
        else if self.validateCellPhone(key) {
            
            parameter = ["cellphonePix":key]
            
            for user in users {
                
                if user.emailPix == key {
                    
                    parameter = ["":""]
                }
            }
        }
        else if self.validateCPF(key) {
            
            parameter = ["cpfPix":key]
            
            for user in users {
                
                if user.emailPix == key {
                    
                    parameter = ["":""]
                }
            }
        }
        else {
            
            parameter = ["":""]
        }
        
        if parameter != ["":""] {
            
            AF.request("https://62baed237bdbe01d52938975.mockapi.io/api/users/\(id)",
                       method: .put,
                       parameters: parameter,
                       encoding: JSONEncoding.default).responseJSON {response in
                
                self.alert(messageTitle: "Sucesso!",
                                message: "Sua Chave foi cadastrada com sucesso",
                                buttonTitle: "Ok")
                print("success")
            }
        }
        else {
            
            self.alert(messageTitle: "Falha",
                            message: "Essa chave pix já existe ou voce digitou um valor inválido",
                            buttonTitle: "Ok")
        }
    }
}
