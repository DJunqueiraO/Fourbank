//
//  HomeController.swift
//  Fourbank
//
//  Created by Josicleison on 20/06/22.
//

import Foundation

protocol HomeController {
    
    func balance(_ id: String,
                 _ users: [User]) -> Int?
}

extension HomeController {
    
    func balance(_ id: String,
                 _ users: [User]) -> Int? {
        
        for user in users {

            if user.id == id {

                return user.accountBalance
            }
        }
        return nil
    }
}
