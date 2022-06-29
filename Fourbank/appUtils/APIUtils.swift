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

    func APIFullRequest(completion: @escaping ([User]?) -> Void) {

        let url = "https://62baed237bdbe01d52938975.mockapi.io/api/users"

        AF.request(url).responseJSON {response in

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

        let url = "https://62baed237bdbe01d52938975.mockapi.io/api/users/\(id)"

        AF.request(url).responseJSON {response in

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
    
    func validateUserOnAPI(_ cpf: String,
                           _ completion: @escaping (Bool) -> Void) {
        var result = true
        
        APIFullRequest {users in
            
            if let users = users {
                
                for user in users {
                    
                    if user.cpf == cpf {
                        
                        self.alert(messageTitle: "Falha",
                                   message: "Este CPF já existe.",
                                   buttonTitle: "Ok")
                        result = false
                    }
                }
                completion(result)
            }
        }
    }
    
    func APIPost(_ parameters: [String: Any]) {

        AF.request("https://62baed237bdbe01d52938975.mockapi.io/api/users",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default).responseJSON {response in

            print("Success")
        }
    }
    
    func APIPut(_ id: String,
                _ parameters: [String: Any]) {

        AF.request("https://62baed237bdbe01d52938975.mockapi.io/api/users/\(id)",
                   method: .put,
                   parameters: parameters,
                   encoding: JSONEncoding.default).responseJSON {response in

            print("Success")
        }
    }
}

extension UIViewController {
    
    func validateUserCoreData(_ cpf: String) -> Bool {

        var users: [NSManagedObject] = []

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return false}

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserCoreData")

        do {
            users = try managedContext.fetch(fetchRequest)

            for user in users {

                if user.value(forKey: "cpf") as? String != nil {

                    if cpf == user.value(forKey: "cpf") as? String {
                        
                        alert(messageTitle: "Falha no cadastro",
                                   message: "O CPF já foi cadastrado.",
                                   buttonTitle: "Ok")
                        return false
                    }
                }
            }
        }
        catch let error as NSError {
            
            alert(messageTitle: "Falha no cadastro",
                       message: "Erro: \(error)",
                       buttonTitle: "Ok")
            print(error)
            return false
        }
        return true
    }
}

struct User: Codable {
    
    let account: String
    let agency: String
    let bank: String
    var accountBalance: Int
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
