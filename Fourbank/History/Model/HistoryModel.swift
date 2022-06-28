//
//  PaymentHistoryModel.swift
//  Fourbank
//
//  Created by Josicleison on 11/06/22.
//

import Foundation

struct CardPayments: Codable {
    
    var id: Int64
    var data: String
    var value: Int64
    var storeName: String
    
}

struct PixPayment: Codable {
    
    var PixKey: String
    var pixKeyType: String
    var value: Int64
    var keyContent: String
    
}

struct HistoryItem {
    
    let title: String
    var description_date: [String:String]
    var date: String
}
