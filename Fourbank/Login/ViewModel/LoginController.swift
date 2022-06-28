//
//  LoginController.swift
//  Fourbank
//
//  Created by Josicleison Elves on 06/06/22.
//

import Foundation
 
protocol LoginController {
    
    func login(_ email: String,
               _ password: String,
               _ users: [User]) -> String?
}

extension LoginController {
    
    func login(_ email: String,
               _ password: String,
               _ users: [User]) -> String? {
        
        for user in users {

            if user.email == email &&
               user.password == password {

                return user.id
            }
        }
        return nil
    }
}
