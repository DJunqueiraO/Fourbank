//
//  PaymentConfirmViewModel.swift
//  Fourbank
//
//  Created by Josicleison on 23/06/22.
//

import Foundation
import Alamofire

protocol PaymentConfirmViewModel {
    
    func setup(_ value: String,
               _ key: String,
               completion: @escaping (Result<[[String]], Error>) -> Void)
    
    func pixPayment(_ value: Int,
                    _ id: String,
                    _ key: String,
                    completion: @escaping (Bool, Error?) -> Void)
}
    
extension PaymentConfirmViewModel {
    
    func setup(_ value: String,
               _ key: String,
               completion: @escaping (Result<[[String]], Error>) -> Void) {
         
        let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3"
         
        AF.request(url).responseJSON {response in
             
            if let data = response.data {
                 
                do {
                    let users: [User] = try JSONDecoder().decode([User].self, from: data)
                    
                    let today = Date()
                    let moment = moment(today)
                    
                    for user in users {
                        
                        if user.emailPix == key ||
                           user.cpfPix == key ||
                           user.cellPhonePix == key ||
                           user.randowKeyPix == key {
                            
                            completion(.success([["Beneficiário:",user.name],
                                                 ["Valor:",value],
                                                 ["Data do pagamento:","\(moment[0])"],
                                                 ["Creditar esse valor em:",user.account],
                                                 ["CPF:",user.cpf],
                                                 ["Instituição:",user.bank],
                                                 ["Agência:",user.agency]]))
                        }
                    }
                }
                catch {
                     
                    completion(.failure(error))
                }
            }
        }
    }
    
    func pixPayment(_ value: Int,
                    _ id: String,
                    _ key: String,
                    completion: @escaping (Bool, Error?) -> Void) {

         let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3"

         AF.request(url).responseJSON {response in

            if let data = response.data {

                do {
                    let users: [Payment] = try JSONDecoder().decode([Payment].self, from: data)
                    var result: Bool = false
                    
                    for user in users {

                        if user.id == id {
                            
                            result = true
                            
                            let newBalance = user.accountBalance - value
                            
                            let today = Date()
                            let moment = moment(today)
                            
                            var parameters: [String: Any] = ["accountBalance": newBalance as Any,
                                                             "debited": "\(user.debited)#R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
                            if user.debited == "" {
                                
                                parameters = ["accountBalance": newBalance as Any,
                                              "debited": "R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
                            }
                            
                            AF.request("https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3/\(user.id)",
                                       method: .put,
                                       parameters: parameters,
                                       encoding: JSONEncoding.default).responseJSON {response in
                                
                                print("success")
                            }
                        }
                        
                        if user.emailPix == key ||
                           user.cpfPix == key ||
                           user.cellphonePix == key ||
                           user.randowKeyPix == key {
                            
                            result = true
                            
                            let newBalance = user.accountBalance + value
                            
                            let today = Date()
                            let moment = moment(today)
                            
                            var parameters: [String: Any] = ["accountBalance": newBalance as Any,
                                                             "credited": "\(user.credited)R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
                            if user.credited == "" {
                                
                                parameters = ["accountBalance": newBalance as Any,
                                              "credited": "R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
                            }
                            
                            AF.request("https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3/\(user.id)",
                                       method: .put,
                                       parameters: parameters,
                                       encoding: JSONEncoding.default).responseJSON {response in
                                
                                print("success")
                            }
                        }
                    }

                    completion(result, nil)
                }
                catch {

                    completion(false, error)
                }
            }
        }
    }
    
    func moment(_ today: Date) -> [String] {
        
        let day   = (Calendar.current.component(.day, from: today))
        let month = (Calendar.current.component(.month, from: today))
        let year = (Calendar.current.component(.year, from: today))
        
        let hours   = (Calendar.current.component(.hour, from: today))
        let minutes = (Calendar.current.component(.minute, from: today))
        let seconds = (Calendar.current.component(.second, from: today))
        
        let nanoSecond = (Calendar.current.component(.nanosecond, from: today))
        
        return ["\(day)/\(month)/\(year)",
                "\(hours):\(minutes):\(seconds)",
                "\(nanoSecond)"]
    }
}
