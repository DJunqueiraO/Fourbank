//
//  Validate.swift
//  Fourbank
//
//  Created by Josicleison on 24/06/22.
//

import UIKit

extension UIViewController {
    
    func validateTextField(_ text: String) -> Bool {
        
        if text != "" {

            return true
        }
        alert(messageTitle: "Falha",
                   message: "Favor digite algum valor válido.",
                   buttonTitle: "Ok")
        
        return false
    }
    
    func validateCPF(_ cpf: String) -> Bool {
        
        if cpf.isCPF {
            
            return true
        }
        alert(messageTitle: "Falha",
                   message: "Favor digite um CPF válido.",
                   buttonTitle: "Ok")
        return false
    }
    
    func validatePassword(_ password: String,
                          _ passwordConfirm: String) -> Bool {
        
        if password == passwordConfirm {
            
            return true
        }
        alert(messageTitle: "Falha",
                   message: "Confirme sua senha corretamente.",
                   buttonTitle: "Ok")
        return false
    }
    
    func validateEmail(_ email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if emailPred.evaluate(with: email) {
            
            return true
        }
        alert(messageTitle: "Falha",
                   message: "Favor digite um e-mail válido.",
                   buttonTitle: "Ok")
        return false
    }
    
    func validateDate(_ date: String) -> Bool {
        
        let dateRegEx = "[0-9]{2}+/[0-9]{2}+/[0-9]{4}||[0-9]{8}"
        
        let datePred = NSPredicate(format:"SELF MATCHES %@", dateRegEx)
        
        if datePred.evaluate(with: date) {
            
            return true
        }
        alert(messageTitle: "Falha",
                   message: "Favor digite uma data válida.",
                   buttonTitle: "Ok")
        return false
    }
    
    func validateName(_ name: String) -> Bool {
        
        let nameRegEx = "(?<! )[A-ZÀ-Ú]+[-a-zà-ú']+ [A-ZÀ-Ú]+[-a-zà-ú']{2,26}"

        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        
        if namePred.evaluate(with: name) {
            
            return true
        }
        alert(messageTitle: "Falha",
                   message: "Favor digite um nome válido.",
                   buttonTitle: "Ok")
        return false
    }
    
    func validateCellPhone(_ phone: String) -> Bool {
        
        let phoneRegEx = "\\([0-9]{2}+\\)[0-9]{5}+-[0-9]{4}||[0-9]{11}"

        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        
        if phonePred.evaluate(with: phone) {
            
            return true
        }
        alert(messageTitle: "Falha",
                   message: "Favor digite um número válido.",
                   buttonTitle: "Ok")
        return false
    }
    
    func validateCep(_ cep: String) -> Bool {
        
        let cepRegEx = "[0-9]{5}+[0-9]{3}||[0-9]{5}+-[0-9]{3}"

        let cepPred = NSPredicate(format:"SELF MATCHES %@", cepRegEx)
        
        if cepPred.evaluate(with: cep) {
            
            return true
        }
        alert(messageTitle: "Falha",
                   message: "Favor digite um cep válido.",
                   buttonTitle: "Ok")
        return false
    }
    
    func validateNumber(_ number: String) -> Bool {
        
        let numberRegEx = "[0-9]*"

        let numberPred = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        
        if numberPred.evaluate(with: number) {
            
            return true
        }
        alert(messageTitle: "Falha",
                   message: "Favor digite um número válido.",
                   buttonTitle: "Ok")
        return false
    }
}

import Alamofire
import CoreData

extension UIViewController {
    
    func validateUserAPI(_ cpf: String,
                         _ completion: @escaping (Bool, Error?) -> Void) {
        
        let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3"
        
        AF.request(url).responseJSON {response in

            if let data = response.data {

                do {

                    let users: [User] = try JSONDecoder().decode([User].self, from: data)
                    var result: Bool = true
                    
                    for user in users {
                        
                        if user.cpf == cpf {
                            
                            self.alert(messageTitle: "Falha no cadastro",
                                            message: "Este CPF já foi cadastrado.",
                                            buttonTitle: "Ok")
                            result = false
                        }
                    }
                    
                    completion(result, nil)
                }
                catch {
                    
                    self.alert(messageTitle: "Falha no cadastro",
                                    message: "Erro: \(error)",
                                    buttonTitle: "Ok")
                    completion(false, error)
                }
            }
        }
    }
    
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

