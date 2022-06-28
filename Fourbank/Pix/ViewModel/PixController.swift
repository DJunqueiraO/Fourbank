//
//  PixController.swift
//  Fourbank
//
//  Created by Josicleison on 20/06/22.
//

import Foundation
import Alamofire

protocol PixController {
    
    func setup(_ id: String,
               completion: @escaping (Result<[[String]], Error>) -> Void)
}

extension PixController {
    
    func validatePixKey(_ key: String,
                        completion: @escaping (Bool, Error?) -> Void) {
         
         let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3"
         
         AF.request(url).responseJSON {response in
             
            if let data = response.data {
                 
                do {
                     
                    let users: [RegisterAPIDoEvandro] = try JSONDecoder().decode([RegisterAPIDoEvandro].self, from: data)
                    var result: Bool = false
                    
                    for user in users {
                        
                        if user.emailPix == key ||
                           user.cpfPix == key ||
                           user.cellphonePix == key ||
                           user.randowKeyPix == key {
                            
                            result = true
                        }
                    }
                    
                    completion(result, nil)
                }
                catch {
                     
                     completion(false, error)
                }
            }
        }
    }
    
    func setup(_ id: String,
               completion: @escaping (Result<[[String]], Error>) -> Void) {
         
         let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3"
         
         AF.request(url).responseJSON {response in
             
            if let data = response.data {
                 
                do {
                     
                    let users: [RegisterAPIDoEvandro] = try JSONDecoder().decode([RegisterAPIDoEvandro].self, from: data)
                    var names: [String] = []
                    var pixkeys: [String] = []
                    
                    for user in users {
                        
                        if user.id != id {
                            
                            names.append(user.name)
                            pixkeys.append(user.emailPix)
                        }
                    }
                    
                    completion(.success([names,pixkeys]))
                }
                catch {
                     
                     completion(.failure(error))
                }
            }
        }
    }
}
