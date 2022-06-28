//
//  PaymentConfirmModel.swift
//  Fourbank
//
//  Created by Josicleison on 26/06/22.
//

import Foundation

struct Payment: Codable {
    
    let account: String
    let agency: String
    let bank: String
    let cityBank: String
    let stateBank: String
    let accountBalance: Int
    let name: String
    let birthDate: String
    let cpf: String
    let rg: String
    let email, password, street, number: String
    let cep, neighborhood, city, state: String
    let cellphoneNumber, cpfPix, emailPix, cellphonePix: String
    let randowKeyPix: String
    let cvv, value, cardNumber: Int
    let id: String
    let credited: String
    let debited: String
}
