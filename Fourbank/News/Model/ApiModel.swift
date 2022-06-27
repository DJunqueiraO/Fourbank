//
//  ApiModel.swift
//  Fourbank
//
//  Created by user218968 on 6/9/22.
//

import Foundation

struct Coins: Codable {
    var rates: [Rates]
}

struct Rates: Codable {
    var asset_id_quote: String
    var rate: Double
}






 
