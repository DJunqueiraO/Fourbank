//
//  LoginView.swift
//  Fourbank
//
//  Created by Josicleison Elves on 01/06/22.
//

import UIKit

class LoginView: UIViewController, LoginController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Fazer Login" {
            
            if validateTextField(emailTextField.text ?? "") &&
               validateTextField(passwordTextField.text ?? "") {
                
                APIFullRequest {users in
                    
                    if let users = users {
                        
                        let user = self.login(self.emailTextField.text ?? "",
                                              self.passwordTextField.text ?? "",
                                              users)
                        if let user = user {
                            
                            let homeView = HomeView(nibName: "HomeView", bundle: nil)
                            homeView.modalPresentationStyle = .fullScreen
                            homeView.user = user
                            self.present(homeView, animated: true, completion: nil)
                        }
                        else {
                            
                            self.alert(messageTitle: "Falha",
                                            message: "Login ou senha invalido",
                                            buttonTitle: "Ok")
                        }
                    }
                }
            }
        }
        else {
            
            let registerView = RegisterView()
            registerView.modalPresentationStyle = .fullScreen
            present(registerView, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        let newsView = NewsView(nibName: "NewsView", bundle: nil)
        newsView.modalPresentationStyle = .fullScreen
        present(newsView, animated: true, completion: nil)
    }
}
