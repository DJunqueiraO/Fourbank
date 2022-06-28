//
//  APIUtils.swift
//  Fourbank
//
//  Created by Josicleison on 27/06/22.
//

import Alamofire
import UIKit

extension UIViewController {

    func APIrequest(completion: @escaping ([PerfilAPI]?) -> Void) {

        let url = "https://62ad2075402135c7acbce26b.mockapi.io/api/v1/account3"

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
}
