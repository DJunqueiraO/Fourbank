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
    
    func perfilDataUnwraper(_ user: User) -> [[String]] {
        
        return [["Agência:", user.agency],
                ["Conta:", user.account],
                ["Nome:", user.name],
                ["Email:", user.email],
                ["Celular:", user.cellPhone],
                ["CEP:", user.cep],
                ["Logradouro:", user.street],
                ["Número:", user.number],
                ["Bairro:", user.district],
                ["Cidade:", user.city],
                ["Estado:", user.state],
                ["EmailPix:", user.emailPix],
                ["CelularPix:", user.cellPhonePix],
                ["CPFPix:", user.cpfPix]]
    }
    
    func putOnAPI(_ id: String,
                  _ dataTypeToModify: Int,
                  _ dataToModify: String) -> [String: Any]? {
        
        let dataType: String,
            data: String
        
        switch dataTypeToModify {
            
            case 0: dataType = "agency"
            
                self.alert(messageTitle: "Falha!",
                                message: "Você não pode alterar esse dado.",
                                buttonTitle: "Ok")
                return nil
            
            case 1: dataType = "account"
            
                self.alert(messageTitle: "Falha!",
                                message: "Você não pode alterar esse dado.",
                                buttonTitle: "Ok")
                return nil
            
            case 2: dataType = "name"
            
                if validateName(dataToModify) {
                    
                    data = dataToModify
                }
                else {
                    
                    return nil
                }
            
            case 3: dataType = "email"
            
                if validateEmail(dataToModify) {
                    
                    data = dataToModify
                }
                else {
                    
                    return nil
                }
            
            case 4: dataType = "cellPhone"
            
                if validateCellPhone(dataToModify) {
                    
                    data = dataToModify
                }
                else {
                    
                    return nil
                }
            
            case 5: dataType = "cep"
            
                if validateCep(dataToModify) {
                    
                    data = dataToModify
                }
                else {
                    
                    return nil
                }
            
            case 6: dataType = "street"
            
                data = dataToModify
            
            case 7: dataType = "number"
            
                data = dataToModify
            
            case 8: dataType = "district"
            
                data = dataToModify
            
            case 9: dataType = "city"
            
                data = dataToModify
            
            case 10: dataType = "state"
            
                data = dataToModify
            
            case 11: dataType = "emailPix"

                if validateEmail(dataToModify) {

                    data = dataToModify
                }
                else {

                    return nil
                }

            case 12: dataType = "cellPhonePix"

                if validateCellPhone(dataToModify) {

                    data = dataToModify
                }
                else {

                    return nil
                }

            default: dataType = "cpfPix"

                if validateCPF(dataToModify) {

                    data = dataToModify
                }
                else {

                    return nil
                }
        }
        
        return  [dataType: data as Any]
    }
}
