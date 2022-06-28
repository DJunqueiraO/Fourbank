//
//  HistoryViewModel.swift
//  Fourbank
//
//  Created by user218968 on 6/26/22.
//

import Foundation
import Alamofire

protocol HistoryViewModel {
    
    func setup(_ id: String,
               completion: @escaping (Result<([String],[String]), Error>) -> Void)
}

extension HistoryViewModel {
    
    func setup(_ id: String,
               completion: @escaping (Result<([String],[String]), Error>) -> Void) {
         
        let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3"
         
        AF.request(url).responseJSON {response in
             
            if let data = response.data {
                 
                do {
                    let users: [Payment] = try JSONDecoder().decode([Payment].self, from: data)
                    
                    var credited: [String] = []
                    var debited: [String] = []
                    
                    for user in users {
                        
                        if user.id == id {
                            
                            credited = stringConverter(user.credited)
                            debited = stringConverter(user.debited)
                        }
                    }
                   
                    completion(.success((credited, debited)))
                }
                catch {
                     
                    completion(.failure(error))
                }
            }
        }
    }
    
    func stringConverter(_ string: String) -> [String] {
        
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
