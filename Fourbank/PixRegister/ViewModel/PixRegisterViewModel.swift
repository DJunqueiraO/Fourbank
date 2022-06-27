//
//  PixRegisterViewModel.swift
//  Fourbank
//
//  Created by Josicleison on 22/06/22.
//

import Foundation
import Alamofire
import UIKit

protocol PixRegisterViewModel {
    
    func randomPixKeyGeneratorAPI(_ id: String,
                                  completion: @escaping (Bool, Error?) -> Void)
    func registerPix(_ id: String,
                     _ key: String,
                     completion: @escaping (Bool, Error?) -> Void)
}

extension PixRegisterViewModel {
    
    func randomPixKeyGeneratorAPI(_ id: String,
                                  completion: @escaping (Bool, Error?) -> Void) {
        
        let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3"
        
        AF.request(url).responseJSON {response in

            if let data = response.data {

                do {

                    let users: [RegisterAPIDoEvandro] = try JSONDecoder().decode([RegisterAPIDoEvandro].self, from: data)

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

                    AF.request("\(url)/\(id)",
                               method: .put,
                               parameters: parameter,
                               encoding: JSONEncoding.default).responseJSON {response in
                        print("success")
                    }

                    completion(true, nil)
                }
                catch {

                    completion(false, error)
                }
            }
        }
    }
    
    func registerPix(_ id: String,
                     _ key: String,
                     completion: @escaping (Bool, Error?) -> Void) {
        
        let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3"
        
        var parameter: [String: String] = ["":""]
        
        AF.request(url).responseJSON {response in
            
            if let data = response.data {
                
                do {
                    
                    let users: [RegisterAPIDoEvandro] = try JSONDecoder().decode([RegisterAPIDoEvandro].self, from: data)
                    var result: Bool = true
                    
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
                        
                        AF.request("\(url)/\(id)",
                                   method: .put,
                                   parameters: parameter,
                                   encoding: JSONEncoding.default).responseJSON {response in
                            print("success")
                        }
                    }
                    else {
                        result = false
                        print("Nao foi possivel efetuar cadastro")
                    }
                    
                    completion(result, nil)
                }
                catch {
                    
                    completion(false, error)
                }
            }
        }
    }
    
    func validateEmail(_ email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if emailPred.evaluate(with: email) {
            
            return true
        }
        return false
    }
    
    func validateCellPhone(_ phone: String) -> Bool {
        
        let phoneRegEx = "\\([0-9]{2}+\\)[0-9]{5}+-[0-9]{4}||[0-9]{11}"

        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        
        if phonePred.evaluate(with: phone) {
            
            return true
        }
        return false
    }
    
    func validateCPF(_ cpf: String) -> Bool {
        
        if cpf.isCPF {
            
            return true
        }
        return false
    }
}
