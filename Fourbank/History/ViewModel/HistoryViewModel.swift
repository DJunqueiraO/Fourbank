//
//  HistoryViewModel.swift
//  Fourbank
//
//  Created by user218968 on 6/26/22.
//

import Foundation
import Alamofire

protocol HistoryViewModel {
    
    func arrayToStringConverter(_ string: String) -> [String]
}

extension HistoryViewModel {
    
    func arrayToStringConverter(_ string: String) -> [String] {
        
        var word = ""
        var words: [String] = []
    
        for char in string {
            
            if char == "#" {
                
                print(word)
                words.append(word)
                word = ""
            }
            else {
                word.append(char)
            }
        }
        
        return words
    }
}
