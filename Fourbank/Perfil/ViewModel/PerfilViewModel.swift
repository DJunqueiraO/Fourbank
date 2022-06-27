//
//  PerfilViewModel.swift
//  Fourbank
//
//  Created by user220265 on 6/21/22.
//

import Foundation
import Alamofire
import UIKit
    
class PerfilViewModel: UIViewController {
    
    func setup(_ id: String,
               completion: @escaping (Result<[[String]], Error>) -> Void) {
         
        let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3"
         
        AF.request(url).responseJSON {response in
             
            if let data = response.data {
                 
                do {
                     
                    let users: [PerfilAPI] = try JSONDecoder().decode([PerfilAPI].self, from: data)

                    for user in users {
                        if user.id == id {
                             
                            completion(.success([["Agência:", user.agency],
                                                 ["Conta:", user.account],
                                                 ["Nome:", user.name],
                                                 ["Email:", user.email],
                                                 ["Celular:", user.cellphone],
                                                 ["CEP:", user.cep],
                                                 ["Logradouro:", user.street],
                                                 ["Número:", user.number],
                                                 ["Bairro:", user.neighborhood],
                                                 ["Cidade:", user.city],
                                                 ["Estado:", user.state]]))
//                                                 ["EmailPix:", user.emailPix],
//                                                 ["CelularPix:", user.cellphonePix],
//                                                 ["CPFPix:", user.cpfPix]]))
                        }
                    }
                }
                catch {
                     
                    completion(.failure(error))
                }
            }
        }
    }
    
    func putOnAPI(_ id: String,
                  _ dataTypeToModify: Int,
                  _ dataToModify: String) -> Bool {
        
        let dataType: String,
            data: String
        
        switch dataTypeToModify {
            
            case 0: dataType = "agency"
            
                self.alertOther(messageTitle: "Falha!",
                                message: "Você não pode alterar esse dado.",
                                buttonTitle: "Ok")
                return false
            
            case 1: dataType = "account"
            
                self.alertOther(messageTitle: "Falha!",
                                message: "Você não pode alterar esse dado.",
                                buttonTitle: "Ok")
                return false
            
            case 2: dataType = "name"
            
                if validateName(dataToModify) {
                    
                    data = dataToModify
                }
                else {
                    
                    return false
                }
            
            case 3: dataType = "email"
            
                if validateEmail(dataToModify) {
                    
                    data = dataToModify
                }
                else {
                    
                    return false
                }
            
            case 4: dataType = "cellphone"
            
                if validateCellPhone(dataToModify) {
                    
                    data = dataToModify
                }
                else {
                    
                    return false
                }
            
            case 5: dataType = "cep"
            
                if validateCep(dataToModify) {
                    
                    data = dataToModify
                }
                else {
                    
                    return false
                }
            
            case 6: dataType = "street"
            
                data = dataToModify
            
            case 7: dataType = "number"
            
                data = dataToModify
            
            case 8: dataType = "neighborhood"
            
                data = dataToModify
            
            case 9: dataType = "city"
            
                data = dataToModify
            
            default: dataType = "state"
            
                data = dataToModify
            
//            case 11: dataType = "emailPix"
//
//                if validateEmail(dataToModify) {
//
//                    data = dataToModify
//                }
//                else {
//
//                    return false
//                }
//
//            case 12: dataType = "cellphonePix"
//
//                if validateCellPhone(dataToModify) {
//
//                    data = dataToModify
//                }
//                else {
//
//                    return false
//                }
//
//            default: dataType = "cpfPix"
//
//                if validateCPF(dataToModify) {
//
//                    data = dataToModify
//                }
//                else {
//
//                    return false
//                }
        }

        let parameters: [String: Any] = [dataType: data as Any]

        AF.request("https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3/\(id)",
                   method: .put,
                   parameters: parameters,
                   encoding: JSONEncoding.default).responseJSON {response in
            
            print("Success: \(response)")
        }
        return true
    }
}
