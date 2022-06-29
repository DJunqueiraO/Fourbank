//
//  PaymentConfirmViewModel.swift
//  Fourbank
//
//  Created by Josicleison on 23/06/22.
//

import Foundation
import Alamofire

protocol PaymentConfirmViewModel {
    
    func paymentReceiverData(_ value: String,
                             _ key: String,
                             _ users: [User]) -> [[String]]?
    func payment(_ value: Int,
                 _ id: String,
                 _ key: String,
                 _ users: [User])
    func moment(_ today: Date) -> [String]
}
    
extension PaymentConfirmViewModel {
    
    func paymentReceiverData(_ value: String,
                             _ key: String,
                             _ users: [User]) -> [[String]]? {
         
        let today = Date()
        
        let moment = moment(today)
        
        for user in users {
            
            if user.emailPix == key ||
               user.cpfPix == key ||
               user.cellPhonePix == key ||
               user.randowKeyPix == key {
                
                return [["Beneficiário:",user.name],
                        ["Valor:",value],
                        ["Data do pagamento:","\(moment[0])"],
                        ["Creditar esse valor em:",user.account],
                        ["CPF:",user.cpf],
                        ["Instituição:",user.bank],
                        ["Agência:",user.agency]]
            }
        }
        return nil
    }
    
    func payment(_ value: Int,
                 _ id: String,
                 _ key: String,
                 _ users: [User]) {
        let url = "https://62baed237bdbe01d52938975.mockapi.io/api/users"
        
        for user in users {

            if user.id == id {
                
                let newBalance = user.accountBalance - value
                
                let today = Date()
                let moment = moment(today)
                
                var parameters: [String: Any] = ["accountBalance": newBalance as Any,
                                                 "debited": "\(user.debited)#R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
                if user.debited == "" {
                    
                    parameters = ["accountBalance": newBalance as Any,
                                  "debited": "R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
                }
                            
                AF.request("\(url)/\(user.id)",
                           method: .put,
                           parameters: parameters,
                           encoding: JSONEncoding.default).responseJSON {response in
                    
                    print("success")
                }
            }
                        
            if user.emailPix == key ||
               user.cpfPix == key ||
               user.cellPhonePix == key ||
               user.randowKeyPix == key {
                
                let newBalance = user.accountBalance + value
                
                let today = Date()
                let moment = moment(today)
                
                var parameters: [String: Any] = ["accountBalance": newBalance as Any,
                                                 "credited": "\(user.credited)R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
                if user.credited == "" {
                    
                    parameters = ["accountBalance": newBalance as Any,
                                  "credited": "R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
                }
                
                AF.request("\(url)/\(user.id)",
                           method: .put,
                           parameters: parameters,
                           encoding: JSONEncoding.default).responseJSON {response in
                    
                    print("success")
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
