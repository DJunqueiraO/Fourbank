//
//  CardModel.swift
//  Fourbank
//
//  Created by user218968 on 6/17/22.
//

import Foundation

struct CardPayment: Codable {
    
    var cardName: String
    var flag: String
    var value: Int64
    var storeName: String
}

struct CardPassword: Codable {
    
    var password: String
}

struct CardNumber: Codable {
    
    var cardNumber: String
}

