//
//  APIUtils.swift
//  Fourbank
//
//  Created by Josicleison on 27/06/22.
//

import Alamofire
import UIKit

extension UIViewController {

    func APIFullRequest(completion: @escaping ([User]?) -> Void) {

        let url = "https://62baed237bdbe01d52938975.mockapi.io/api/users"

        AF.request(url).responseJSON {response in

            if let data = response.data {

                do {
                    let users: [User] = try JSONDecoder().decode([User].self, from: data)

                    completion(users)
                }
                catch {

                    self.alertOther(messageTitle: "Falha",
                                    message: "Erro: \(error)",
                                    buttonTitle: "Ok")
                    completion(nil)
                }
            }
        }
    }
    
    func APIRequest(_ id: String,
                    completion: @escaping (User?) -> Void) {

        let url = "https://62baed237bdbe01d52938975.mockapi.io/api/users/\(id)"

        AF.request(url).responseJSON {response in

            if let data = response.data {

                do {
                    let user: User = try JSONDecoder().decode(User.self, from: data)

                    completion(user)
                }
                catch {

                    self.alertOther(messageTitle: "Falha",
                                    message: "Erro: \(error)",
                                    buttonTitle: "Ok")
                    completion(nil)
                }
            }
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
    let cardNumber: Int
    let id: String
}

