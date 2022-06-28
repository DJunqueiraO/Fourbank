//
//  APIUtils.swift
//  Fourbank
//
//  Created by Josicleison on 27/06/22.
//

import Alamofire
import UIKit

extension UIViewController {

    func APIFullRequest(completion: @escaping ([PerfilAPI]?) -> Void) {

        let url = "https://62baecc67bdbe01d52937f9a.mockapi.io/"

        AF.request(url).responseJSON {response in

            if let data = response.data {

                do {
                    let users: [PerfilAPI] = try JSONDecoder().decode([PerfilAPI].self, from: data)

                    completion(users)
                }
                catch {

                    self.alertOther(messageTitle: "Falha",
                                    message: "Erro: \(error)",
                                    buttonTitle: "Ok")
                    completion(nil)
                }
            }
        }
    }
    
    func APIrequest(_ id: String,
                    completion: @escaping (PerfilAPI?) -> Void) {

        let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3/\(id)"

        AF.request(url).responseJSON {response in

            if let data = response.data {

                do {
                    let user: PerfilAPI = try JSONDecoder().decode(PerfilAPI.self, from: data)

                    completion(user)
                }
                catch {

                    self.alertOther(messageTitle: "Falha",
                                    message: "Erro: \(error)",
                                    buttonTitle: "Ok")
                    completion(nil)
                }
            }
        }
    }
}
