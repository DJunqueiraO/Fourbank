//
//  CardController.swift
//  Fourbank
//
//  Created by Josicleison on 20/06/22.
//

import Foundation

protocol CardController {
    
    func cardData(_ id: String,
                  _ users: [PerfilAPI]) -> [String]?
}

extension CardController {
    
    func cardData(_ id: String,
                  _ users: [PerfilAPI]) -> [String]? {

        for user in users {
            
            if user.id == id {
                 
                return [user.name, String(user.cardNumber)]
            }
        }
        return nil
    }
}
