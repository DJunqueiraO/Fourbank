//
//  PixRegisterView.swift
//  Fourbank
//
//  Created by Josicleison on 22/06/22.
//

import UIKit

class PixRegisterView: PixRegisterViewModel{

    @IBOutlet weak var pixRegisterTextField: UITextField!
    @IBOutlet weak var tabBar: UITabBar!
    
    var user = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tabBar.delegate = self
    }
    
    @IBAction func randomKeyButton(_ sender: UIButton) {
        
        APIFullRequest {users in
            
            if let users = users {
                
                self.randomPixKeyGeneratorAPI(self.user, users)
            }
        }
    }
    
    @IBAction func pixRegisterButton(_ sender: UIButton) {
        
        if validateTextField(pixRegisterTextField.text ?? "") {
            
            APIFullRequest {users in
                
                if let users = users {
                    
                    self.registerPix(self.user,
                                     self.pixRegisterTextField.text ?? "",
                                     users)
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        let pixAreaView = PixAreaView(nibName: "PixAreaView", bundle: nil)
        pixAreaView.modalPresentationStyle = .fullScreen
        pixAreaView.user = user
        present(pixAreaView, animated: true, completion: nil)
    }
}

extension PixRegisterView: UITabBarDelegate  {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        guard let item = item.title else {return}
        
        switch item {
        case "Perfil":

            let perfilView = PerfilView(nibName: "PerfilView", bundle: nil)
            perfilView.modalPresentationStyle = .fullScreen
            perfilView.user = user
            present(perfilView, animated: true, completion: nil)

        default:

            let homeView = HomeView(nibName: "HomeView", bundle: nil)
            homeView.modalPresentationStyle = .fullScreen
            homeView.user = user
            present(homeView, animated: true, completion: nil)
        }
    }
}
