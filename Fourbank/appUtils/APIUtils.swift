//
//  APIUtils.swift
//  Fourbank
//
//  Created by Josicleison on 27/06/22.
//


import CoreData
import Alamofire
import UIKit

extension UIViewController {
    
    func urlRead() -> String {
        
        return "https://62baed237bdbe01d52938975.mockapi.io/api/users"
    }
    
    func APIFullRequest(completion: @escaping ([User]?) -> Void) {
        
        AF.request(urlRead()).responseJSON {response in

            if let data = response.data {

                do {
                    let users: [User] = try JSONDecoder().decode([User].self, from: data)

                    completion(users)
                }
                catch {

                    self.alert(messageTitle: "Falha",
                                    message: "Erro: \(error)",
                                    buttonTitle: "Ok")
                    completion(nil)
                }
            }
        }
    }
    
    func APIRequest(_ id: String,
                    completion: @escaping (User?) -> Void) {

        AF.request("\(urlRead())/\(id)").responseJSON {response in

            if let data = response.data {

                do {
                    let user: User = try JSONDecoder().decode(User.self, from: data)

                    completion(user)
                }
                catch {

                    self.alert(messageTitle: "Falha",
                                    message: "Erro: \(error)",
                                    buttonTitle: "Ok")
                    completion(nil)
                }
            }
        }
    }
    
    func APIPost(_ parameters: [String: Any]) {

        AF.request(urlRead(),
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default).responseJSON {response in
            
            print("Success")
        }
    }
    
    func APIPut(_ id: String,
                _ parameters: [String: Any]) {

        AF.request("\(urlRead())/\(id)",
                   method: .put,
                   parameters: parameters,
                   encoding: JSONEncoding.default).responseJSON {response in
            
            print("Success")
        }
    }
}

struct User: Codable {
    
    let account: String
    let agency: String
    let bank: String
    let accountBalance: Int
    let name: String
    let birthDate: String
    let cpf: String
    let rg: String
    let cellPhone: String
    let email: String
    let password: String
    let street: String
    let number: String
    let cep: String
    let district: String
    let city: String
    let state: String
    let cpfPix: String
    let emailPix: String
    let cellPhonePix: String
    let randowKeyPix: String
    let cardNumber: String
    let id: String
    let credited: String
    let debited: String
}
