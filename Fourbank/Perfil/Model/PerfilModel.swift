//
//  PerfilModel.swift
//  Fourbank
//
//  Created by user218968 on 6/17/22.
//

import Foundation

struct ClientInfo: Codable {
    
    var id: Int64
    var name: String
    var cpf: String
    var email: String
    var cellphone: String
    var birthDate: String
    var monthlyIncome: Int64
    var clientType: String
}

struct ClientAccount: Codable {
    
    var number: Int64
    var agency: Int64
    var bankNumber: Int64
    var balance: Int64
}

struct PerfilAPI: Codable {
    
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
    let cellphone: String
    let email, password, street, number: String
    let cep, neighborhood, city, state: String
    let cellphoneNumber, cpfPix, emailPix, cellphonePix: String
    let randowKeyPix: String
    let cvv, value, cardNumber: Int
    let id: String
}

