//
//  PixRegisterView.swift
//  Fourbank
//
//  Created by Josicleison on 22/06/22.
//

import UIKit

class PixRegisterView: UIViewController, PixRegisterViewModel {

    @IBOutlet weak var pixRegisterTextField: UITextField!
    
    var user = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func randomKeyButton(_ sender: UIButton) {
        
        randomPixKeyGeneratorAPI(user) {result, error in

            if result {
                
                self.alertOther(messageTitle: "Sucesso", message: "Sua chave aleatoria foi cadastrada com sucesso", buttonTitle: "Ok")
            }
            else {
                
                self.alertOther(messageTitle: "Falha ao cadastrar", message: "erro: \(error!)", buttonTitle: "Ok")
            }
        }
    }
    
    @IBAction func pixRegisterButton(_ sender: UIButton) {
        
        if validateTextField(pixRegisterTextField.text ?? "") {
            
            registerPix(user,
                        pixRegisterTextField.text ?? "") {result, error in

                if result {

                    self.alertOther(messageTitle: "Sucesso!",
                                    message: "Sua Chave foi cadastrada com sucesso",
                                    buttonTitle: "Ok")
                    print("Success")
                }
                else {
                    
                    if let error = error {
                        
                        self.alertOther(messageTitle: "Falha",
                                        message: "Erro: \(error)",
                                        buttonTitle: "Ok")
                        print(error)
                    }
                    else {
                        
                        self.alertOther(messageTitle: "Falha",
                                        message: "Essa chave pix já existe ou voce digitou um valor inválido",
                                        buttonTitle: "Ok")
                    }
                }
            }
        }
        else {
            
            self.alertOther(messageTitle: "Falha",
                            message: "Digite uma chave para o cadastro",
                            buttonTitle: "Ok")
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        let pixAreaView = PixAreaView(nibName: "PixAreaView", bundle: nil)
        pixAreaView.modalPresentationStyle = .fullScreen
        pixAreaView.user = user
        present(pixAreaView, animated: true, completion: nil)
    }
}
