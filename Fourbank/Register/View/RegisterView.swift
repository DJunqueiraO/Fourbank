//
//  RegisterView.swift
//  Fourbank
//
//  Created by Josicleison Elves on 01/06/22.
//

import UIKit

class RegisterView: RegisterController {
    
    @IBOutlet weak var greetingsLabel: UILabel!
    
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var registerTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var cepTextField: UITextField!
    
    @IBOutlet weak var accountTypeSegmentControl: UISegmentedControl!
    
    var stage: Int8 = 0
    var name, //CADASTRADO
        cpf, //CADASTRADO
        birthDate, //
        cep: String?, //CADASTRADO
        street, //CADASTRADO
        city, //CADASTRADO
        cellphone, //CADASTRADO
        email: String?, //CADASTRADO
        password, //CADASTRADO
        clientType: String?,
        monthlyIncome: Int16?,
        accountType: Int16?,
        
        number: String?,
        district: String?,
        state: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        nextStage()
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        clearFields()
        
        stage = backStage(stage)
    }
}

extension RegisterView {
    
    func clearFields() {
        
        registerTextField.text = ""
        confirmTextField.text = ""
        cepTextField.text = ""
    }
    
    func backStage(_ stage: Int8) -> Int8 {
        
        switch stage {

            case 0:

                let loginView = LoginView(nibName: "LoginView", bundle: nil)
                loginView.modalPresentationStyle = .fullScreen
                present(loginView, animated: true, completion: nil)

            case 2:

                greetingsLabel.text = "Qual o seu nome?"
                registerLabel.text = "Nome:"
                registerTextField.keyboardType = .namePhonePad
                registerTextField.placeholder = "Digite seu nome"

            case 3:

                greetingsLabel.text = "Qual a sua data de nascimento?"
                registerLabel.text = "Data de nascimento:"
                registerTextField.placeholder = "DD/MM/AAAA"

            case 4:

                confirmTextField.isHidden = true
                greetingsLabel.text = "Qual o seu CPF?"
                registerLabel.text = "CPF:"
                registerTextField.placeholder = "Apenas números"

            case 5:

                confirmTextField.isHidden = false
                cepTextField.isHidden = true
                confirmTextField.keyboardType = .numberPad
                registerTextField.keyboardType = .numberPad
                greetingsLabel.text = "Digite uma senha:"
                registerLabel.text = "Senha:"
                registerTextField.placeholder = "Ex: 4Cl13nt3"
                confirmTextField.placeholder = "Confirme a senha"

            case 6:
    
                registerTextField.isHidden = false
                cepTextField.isHidden = false
                accountTypeSegmentControl.isHidden = true
                registerTextField.keyboardType = .default
                greetingsLabel.text = "Qual é o seu endereço?"
                registerLabel.text = "Endereço:"
                registerTextField.placeholder = "Digite sua rua"
                confirmTextField.placeholder = "Cidade"
                cepTextField.placeholder = "CEP"

            case 7:
        
                accountTypeSegmentControl.isHidden = false
                registerTextField.isHidden = true
                confirmTextField.isHidden = false
                greetingsLabel.text = "Dados para criar a conta"
                registerLabel.text = "Tipo de conta:"
                confirmTextField.placeholder = "Sua renda"

            case 8:
            
                greetingsLabel.text = "Qual é o seu e-mail?"
                registerTextField.placeholder = "Digite o seu E-mail"
                registerLabel.text = "E-mail:"

            case 9:
            
                greetingsLabel.text = "Qual é o seu número de celular?"
                registerLabel.text = "Número:"
                registerTextField.placeholder = "(xx) xxxxx-xxxx"

            default:

                let loginView = LoginView(nibName: "LoginView", bundle: nil)
                loginView.modalPresentationStyle = .fullScreen
                present(loginView, animated: true, completion: nil)
        }
        
        return stage - 1
    }
    
    func nextStage() {
        
        switch stage {
                   
           case 0:
           
               stage += 1
               
               registerLabel.isHidden = false
               registerTextField.isHidden = false
               greetingsLabel.text = "Qual o seu nome?"
           
           case 1:
           
               if validateTextField(registerTextField.text ?? "") &&
                  validateName(registerTextField.text ?? "") {
                       
                   name = registerTextField.text
                   stage += 1
                   
                   //preparation for next stage
                   clearFields()
                   
                   greetingsLabel.text = "Qual a sua data de nascimento?"
                   registerLabel.text = "Data de nascimento:"
                   registerTextField.keyboardType = .numberPad
                   registerTextField.placeholder = "DD/MM/AAAA"
               }
                   
           case 2:
           
               if validateTextField(registerTextField.text ?? "") &&
                  validateDate(registerTextField.text ?? "") {
                   
                   birthDate = registerTextField.text
                   stage += 1
                   
                   //preparation for next stage
                   clearFields()
                   
                   registerTextField.keyboardType = .numberPad
                   greetingsLabel.text = "Qual o seu CPF?"
                   registerLabel.text = "CPF:"
                   registerTextField.placeholder = "Apenas números"
               }
           
           case 3:
           
               if validateTextField(registerTextField.text ?? "") &&
                  validateCPF(registerTextField.text ?? "") &&
                  validateUserCoreData(registerTextField.text ?? "") {
                       
                   validateUserOnAPI(registerTextField.text ?? "") {result in
                   
                       if result {
                           
                           self.cpf = self.registerTextField.text ?? ""
                           self.clientType = "PF"
                           self.stage += 1
                           
                           //preparation for next stage
                           self.clearFields()
                           
                           self.confirmTextField.isHidden = false
                           self.confirmTextField.keyboardType = .numberPad
                           self.cepTextField.keyboardType = .numberPad
                           self.greetingsLabel.text = "Digite uma senha:"
                           self.registerLabel.text = "Senha:"
                           self.registerTextField.placeholder = "Ex: 4Cl13nt3"
                       }
                   }
               }
           
           case 4:
           
               if validateTextField(registerTextField.text ?? "") &&
                  validatePassword(registerTextField.text ?? "",
                                   confirmTextField.text ?? "") {
                   password = registerTextField.text
                   stage += 1
                   
                   //preparation for next stage
                   clearFields()
                   
                   cepTextField.isHidden = false
                   registerTextField.keyboardType = .default
                   greetingsLabel.text = "Qual é o seu endereço?"
                   registerLabel.text = "Endereço:"
                   registerTextField.placeholder = "Digite sua rua"
                   confirmTextField.placeholder = "Cidade"
                   cepTextField.placeholder = "CEP"
               }
           
           case 5:
           
               if validateTextField(registerTextField.text ?? "") &&
                  validateTextField(confirmTextField.text ?? "") &&
                  validateTextField(cepTextField.text ?? "") &&
                  validateCep(cepTextField.text ?? "") {
                       
                   street = registerTextField.text
                   city = confirmTextField.text
                   cep = cepTextField.text
                   stage += 1
                   
                   //preparation for next stage
                   clearFields()
                   
                   accountTypeSegmentControl.isHidden = false
                   registerTextField.isHidden = true
                   cepTextField.isHidden = true
                   greetingsLabel.text = "Dados para criar a conta"
                   registerLabel.text = "Tipo de conta:"
                   confirmTextField.placeholder = "Sua renda"
               }
           
           case 6:
           
               if validateTextField(confirmTextField.text ?? "") &&
                    validateNumber(confirmTextField.text ?? "") {
                   
                   accountType = Int16(accountTypeSegmentControl.selectedSegmentIndex)
                   monthlyIncome = Int16(confirmTextField.text ??  "")
                   stage += 1
                   
                   //preparation for next stage
                   clearFields()
                   
                   registerTextField.isHidden = false
                   confirmTextField.isHidden = true
                   cepTextField.isHidden = true
                   accountTypeSegmentControl.isHidden = true
                   greetingsLabel.text = "Qual é o seu e-mail?"
                   registerTextField.placeholder = "Digite o seu E-mail"
                   registerLabel.text = "E-mail:"
               }
           
           case 7:
           
               if validateTextField(registerTextField.text ?? "") &&
                  validateEmail(registerTextField.text ?? "") {
                   
                   email = registerTextField.text
                   stage += 1
                   
                   //preparation for next stage
                   clearFields()

                   registerTextField.keyboardType = .numberPad
                   greetingsLabel.text = "Qual é o seu número de celular?"
                   registerLabel.text = "Número:"
                   registerTextField.placeholder = "(xx) xxxxx-xxxx"
                       
               }
           
           case 8:
           
               if validateTextField(registerTextField.text ?? "") &&
                  validateCellPhone(registerTextField.text ?? "") {
                   
                   cellphone = registerTextField.text
                   stage += 1
                   
                   //preparation for next stage
                   registerTextField.text = ""
                   greetingsLabel.text = "Enviamos um código para seu SMS"
                   registerLabel.text = "Código:"
                   registerTextField.placeholder = "Código SMS"
               }
           
           default:
           
               if validateTextField(registerTextField.text ?? "") {

                   stage += 1
                    
                   registerAPI(name ?? "",
                               cpf ?? "",
                               password ?? "",
                               email ?? "",
                               cellphone ?? "",
                               birthDate ?? "",
                               street ?? "",
                               number ?? "",
                               cep ?? "",
                               district ?? "",
                               city ?? "",
                               state ?? "")
                       
                   registerCoreData(name,
                                    cpf,
                                    birthDate,
                                    cep,
                                    street,
                                    city,
                                    cellphone,
                                    email,
                                    password,
                                    clientType,
                                    monthlyIncome,
                                    accountType)
                       
                   finalAlert("Parabéns",
                              "Seu cadastro foi concluido com sucesso!",
                              "Ok")
           }
       }
    }
}
