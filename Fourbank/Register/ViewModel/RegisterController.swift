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
     
    func registerAPI(_ name: String,
                     _ birthDate: String,
                     _ cpf: String,
                     _ cellPhone: String,
                     _ email: String,
                     _ password: String,
                     _ street: String,
                     _ cep: String,
                     _ district: String,
                     _ city: String,
                     _ state: String) {

        let parameters: [String: Any] = ["name": name as Any,
                                         "birthDate": birthDate as Any,
                                         "cpf": cpf as Any,
                                         "cellPhone": cellPhone as Any,
                                         "email": email as Any,
                                         "password": password as Any,
                                         "street": street as Any,
                                         "cep": cep as Any,
                                         "district": district as Any,
                                         "city": city as Any,
                                         "state": state as Any]
        

        AF.request("https://62baed237bdbe01d52938975.mockapi.io/api/users",
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
