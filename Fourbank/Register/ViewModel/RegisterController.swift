//
//  RegisterController.swift
//  Fourbank
//
//  Created by Josicleison Elves on 05/06/22.
//

import UIKit
import CoreData
import Alamofire

class RegisterController: UIViewController {
     
    func registerAPI(_ user: RegisterUser) {

        let parameters: [String: Any] = ["name": user.name as Any,
                                         "cpf": user.cpf as Any,
                                         "password": user.password as Any,
                                         "email": user.email as Any,
                                         "cellphone": user.cellphone as Any,
                                         "birthDate": user.birthDate as Any,
                                         "monthlyIncome": user.monthlyIncome as Any,
                                         "street": user.street as Any,
                                         "number": user.number as Any,
                                         "cep": user.cep as Any,
                                         "district": user.district as Any,
                                         "city": user.city as Any,
                                         "state": user.state as Any,
                                         "credited": "",
                                         "debited": ""]

        AF.request("https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default).responseJSON {response in

            print("Success")
        }
    }
    
    func registerCoreData(_ name: String?,
                          _ cpf: String?,
                          _ birthDate: String?,
                          _ cep: String?,
                          _ street: String?,
                          _ city: String?,
                          _ cellphone: String?,
                          _ email: String?,
                          _ password: String?,
                          _ clientType: String?,
                          _ monthlyIncome: Int16?,
                          _ accountType: Int16?) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
    
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "UserCoreData", in: managedContext)!
        
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        
        guard let cpf = cpf else {return}
        if !validateUserCoreData(cpf)
        {
            user.setValue(name ?? "", forKey: "name")
            user.setValue(cpf ?? "", forKey: "cpf")
            user.setValue(birthDate ?? "", forKey: "birthDate")
            user.setValue(cep ?? "", forKey: "cep")
            user.setValue(street ?? "", forKey: "street")
            user.setValue(city ?? "", forKey: "city")
            user.setValue(cellphone ?? "", forKey: "cellphone")
            user.setValue(email ?? "", forKey: "email")
            user.setValue(password ?? "", forKey: "password")
            user.setValue(clientType ?? "", forKey: "clientType")
            user.setValue(monthlyIncome ?? "", forKey: "monthlyIncome")
            user.setValue(accountType ?? "", forKey: "accountType")
            
            do {
                
                try managedContext.save()
            }
            catch let error as NSError {
                
                print("Erro ao registrar dados. \(error)")
            }
        }
    }
}
