//
//  RegisterModel.swift
//  Fourbank
//
//  Created by Josicleison Elves on 02/06/22.
//

import Foundation

struct RegisterUser: Codable {
    
    let name: String
    let cpf: String
    let password: String
    let email: String
    let cellphone: String
    let birthDate: String
    let monthlyIncome: Int
    let street: String
    let number: String
    let cep: String
    let district: String
    let city: String
    let state: String
}

struct RegisterAPIDoEvandro: Codable {
    
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
    
//    let account, agency, bank, cityBank: String
//    let stateBank: String
//    let accountBalance: Int
//    let name, birthDate, cpf, rg: String
//    let email, password, street, number: String
//    let cep, neighborhood, city, state: String
//    let cellphoneNumber, cpfPix, emailPix, cellphonePix: String
//    let randowKeyPix: Int
//    let cvv, value, cardNumber: Int
//    let id, cellphone: String
//    let monthlyIncome: Int
//    let district: String
}
