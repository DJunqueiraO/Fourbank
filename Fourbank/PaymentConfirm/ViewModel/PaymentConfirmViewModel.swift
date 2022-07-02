//
//  PaymentConfirmViewModel.swift
//  Fourbank
//
//  Created by Josicleison on 23/06/22.
//

import Foundation
import Alamofire
import UIKit
    
class PaymentConfirmViewModel: UIViewController {
    
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
        var payer: User?,
            receiver: User?
        
        for user in users {

            if user.id == id {
                
                payer = user
            }
                        
            if user.emailPix == key ||
               user.cpfPix == key ||
               user.cellPhonePix == key ||
               user.randowKeyPix == key {
                
                receiver = user
            }
        }
        
        if let payer = payer, let receiver = receiver {
            
            var newBalance = payer.accountBalance - value
            
            let today = Date()
            let moment = moment(today)
            
            var parameter: [String: Any] = ["accountBalance": newBalance as Any,
                                             "debited": "\(payer.debited)#R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
            if payer.debited == "" {
                
                parameter = ["accountBalance": newBalance as Any,
                              "debited": "R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
            }
            
            APIPut(payer.id,
                   parameter)
            
            newBalance = receiver.accountBalance + value
            
            parameter = ["accountBalance": newBalance as Any,
                         "credited": "\(receiver.credited)R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
            if receiver.credited == "" {
                
                parameter = ["accountBalance": newBalance as Any,
                              "credited": "R$ \(value) - \(moment[0]) \(moment[1]) \(moment[2])#" as Any]
            }
            
            APIPut(receiver.id,
                   parameter)
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
