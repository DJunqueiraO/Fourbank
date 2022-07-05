//
//  RegisterView.swift
//  Fourbank
//
//  Created by Josicleison Elves on 01/06/22.
//

import UIKit

class RegisterView: RegisterController {
    
    lazy var navigationBar: UINavigationBar = {
        
        let navigationBar = UINavigationBar()
        
        navigationBar.backgroundColor = .red
        navigationBar.pushItem(navigationBarItem, animated: true)
        
        navigationBar.barTintColor = UIColor.fourbankBlue()
        
        return navigationBar
    }()
    
    lazy var navigationBarItem: UINavigationItem = {
        
        let navigationBarItem = UINavigationItem()
        navigationBarItem.leftBarButtonItem = backButton
    
        return navigationBarItem
    }()
    
    let backButton: UIBarButtonItem = {
        
        let backButton = UIBarButtonItem()
        backButton.image = UIImage(systemName: "chevron.left")
        backButton.tintColor = UIColor.fourbankOrange()
    
        return backButton
    }()
    
    lazy var registerView: UIView = {
        
        let registerView = UIView()
        registerView.backgroundColor = .white
        
        registerView.addSubviews([greetingsLabel,
                                  firstStackView,
                                  secondStackView,
                                  registerButton])
        
        return registerView
    }()
    
    let greetingsLabel: UILabel = {
        
        let greetingsLabel = UILabel()
        greetingsLabel.textColor = UIColor.fourbankOrange()
        greetingsLabel.font = UIFont.systemFont(ofSize: 40,
                                                weight: .bold)
        greetingsLabel.numberOfLines = 0
        greetingsLabel.text = "Bem vindo ao Fourbank, vamos fazer seu cadastro"
        
        return greetingsLabel
    }()
    
    lazy var firstStackView: UIStackView = {
        
        let firstStackView = UIStackView(arrangedSubviews: [registerLabel,
                                                            registerTextField,
                                                            accountTypeSegmentedControl])
        firstStackView.axis = .vertical
        firstStackView.distribution = .fillEqually
        
        return firstStackView
    }()
    
    let registerLabel: UILabel = {
        
        let registerLabel = UILabel()
        registerLabel.font = UIFont.systemFont(ofSize: 25,
                                               weight: .bold)
        registerLabel.text = "Nome: "
        registerLabel.textColor = .lightGray
        registerLabel.isHidden = true
        
        return registerLabel
    }()
    
    let registerTextField: UITextField = {
        
        let registerTextField = UITextField()
        registerTextField.font = UIFont.systemFont(ofSize: 25)
        registerTextField.placeholder = "Digite seu nome"
        registerTextField.backgroundColor = .separator
        registerTextField.layer.cornerRadius = 5
        registerTextField.isHidden = true
        
        return registerTextField
    }()
    
    let accountTypeSegmentedControl: UISegmentedControl = {
        
        let accountTypeSegmentedControl = UISegmentedControl()
        accountTypeSegmentedControl.insertSegment(withTitle: "CC",
                                                  at: 0,
                                                  animated: true)
        accountTypeSegmentedControl.insertSegment(withTitle: "CP",
                                                  at: 1,
                                                  animated: true)
        accountTypeSegmentedControl.isHidden = true
        
        return accountTypeSegmentedControl
    }()
    
    lazy var secondStackView: UIStackView = {
        
        let secondStackView = UIStackView(arrangedSubviews: [confirmTextField,
                                                             cepTextField])
        secondStackView.axis = .horizontal
        secondStackView.distribution = .fillEqually
        
        return secondStackView
    }()
    
    let confirmTextField: UITextField = {
        
        let confirmTextField = UITextField()
        confirmTextField.font = UIFont.systemFont(ofSize: 25)
        confirmTextField.backgroundColor = .separator
        confirmTextField.placeholder = "confirme a senha"
        confirmTextField.layer.cornerRadius = 5
        confirmTextField.isHidden = true
        
        return confirmTextField
    }()
    
    let cepTextField: UITextField = {
        
        let cepTextField = UITextField()
        cepTextField.font = UIFont.systemFont(ofSize: 25)
        cepTextField.backgroundColor = .separator
        cepTextField.placeholder = "cep: "
        cepTextField.layer.cornerRadius = 5
        cepTextField.isHidden = true
        
        return cepTextField
    }()
    
    let registerButton: UIButton = {
        
        let registerButton = UIButton()
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 25,
                                                            weight: .bold)
        registerButton.backgroundColor = UIColor.fourbankOrange()
        registerButton.setTitle("Continuar", for: .normal)
        registerButton.layer.cornerRadius = 7
        registerButton.layer.borderWidth = 2
        registerButton.layer.borderColor = CGColor.fourbankBlue()
        
        return registerButton
    }()
    
    var stage: Int8 = 0
    var name, //CADASTRADO
        cpf, //CADASTRADO
        birthDate, //
        cep: String?, //CADASTRADO
        street, //CADASTRADO
        city, //CADASTRADO
        cellPhone, //CADASTRADO
        email: String?, //CADASTRADO
        password, //CADASTRADO
        clientType: String?,
        monthlyIncome: Int16?,
        accountType: Int16?,
        number: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubviews([navigationBar,
                          registerView])
        
        registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        
        backButton.action = #selector(backButtonAction)
        
        view.addConstraints([navigationBar.constraintIncideItem(.top, view.safeAreaLayoutGuide, 0),
                             navigationBar.constraintIncideItem(.leading, view, 0),
                             navigationBar.constraintIncideItem(.trailing, view, 0),
                            
                             registerView.constraintToItem(.top, navigationBar, 0),
                             registerView.constraintIncideItem(.leading, view, 0),
                             registerView.constraintIncideItem(.trailing, view, 0),
                             registerView.constraintIncideItem(.bottom, view, 0),
                             
                             greetingsLabel.constraintIncideItem(.top, registerView, 90),
                             greetingsLabel.constraintIncideItem(.leading, registerView, 20),
                             greetingsLabel.constraintIncideItem(.trailing, registerView, -20),
                            
                             firstStackView.constraintIncideItem(.centerY, registerView, 0),
                             firstStackView.constraintIncideItem(.leading, greetingsLabel, 0),
                             firstStackView.constraintIncideItem(.trailing, greetingsLabel, 0),
                             
                             secondStackView.constraintToItem(.top, firstStackView, 10),
                             secondStackView.constraintIncideItem(.leading, firstStackView, 0),
                             secondStackView.constraintIncideItem(.trailing, firstStackView, 0),
                            
                             registerButton.constraintIncideItem(.leading, registerView, 20),
                             registerButton.constraintIncideItem(.trailing, registerView, -20),
                             registerButton.constraintIncideItem(.bottom, registerView, -65)])
        
        view.backgroundColor = UIColor.fourbankBlue()
    }
    
    @objc func backButtonAction() {
        
        clearFields()

        stage = backStage(stage)
    }
    
    @objc func registerButtonAction(_ sender: UIButton) {

        nextStage()
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
                accountTypeSegmentedControl.isHidden = true
                registerTextField.keyboardType = .default
                greetingsLabel.text = "Qual é o seu endereço?"
                registerLabel.text = "Endereço:"
                registerTextField.placeholder = "Digite sua rua"
                confirmTextField.placeholder = "Cidade"
                cepTextField.placeholder = "CEP"

            case 7:

                accountTypeSegmentedControl.isHidden = false
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

                   accountTypeSegmentedControl.isHidden = false
                   registerTextField.isHidden = true
                   cepTextField.isHidden = true
                   greetingsLabel.text = "Dados para criar a conta"
                   registerLabel.text = "Tipo de conta:"
                   confirmTextField.placeholder = "Sua renda"
               }

           case 6:

               if validateTextField(confirmTextField.text ?? "") &&
                    validateNumber(confirmTextField.text ?? "") {

                   accountType = Int16(accountTypeSegmentedControl.selectedSegmentIndex)
                   monthlyIncome = Int16(confirmTextField.text ??  "")
                   stage += 1

                   //preparation for next stage
                   clearFields()

                   registerTextField.isHidden = false
                   confirmTextField.isHidden = true
                   cepTextField.isHidden = true
                   accountTypeSegmentedControl.isHidden = true
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

                   cellPhone = registerTextField.text
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

                   APIPost(["name": name as Any,
                            "birthDate": birthDate as Any,
                            "cpf": cpf as Any,
                            "cellPhone": cellPhone as Any,
                            "email": email as Any,
                            "password": password as Any,
                            "street": street as Any,
                            "cep": cep as Any,
                            "district": "",
                            "city": city as Any,
                            "state": "",
                            "account": "",
                            "agency": "",
                            "bank": "",
                            "accountBalance": 1500,
                            "rg": "",
                            "number": "",
                            "cpfPix": "",
                            "emailPix": "",
                            "cellPhonePix": "",
                            "randowKeyPix": "",
                            "cardNumber": "",
                            "id": "",
                            "credited": "",
                            "debited": ""])

                   registerCoreData(name,
                                    cpf,
                                    birthDate,
                                    cep,
                                    street,
                                    city,
                                    cellPhone,
                                    email,
                                    password,
                                    clientType,
                                    monthlyIncome,
                                    accountType)

                   finalAlert("Parabéns",
                              "Seu cadastro foi concluido com sucesso!",
                              "Ok",
                              LoginView(nibName: "LoginView", bundle: nil))
            }
        }
    }
}

extension UIView {
    
    open func constraintIncideItem(_ attribute: NSLayoutConstraint.Attribute,
                               _ element: Any?,
                               _ constant: CGFloat) -> NSLayoutConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        return NSLayoutConstraint(item: self,
                                  attribute: attribute,
                                  relatedBy: .equal,
                                  toItem: element,
                                  attribute: attribute,
                                  multiplier: 1,
                                  constant: constant)
    }
    
    open func constraintToItem(_ attribute: NSLayoutConstraint.Attribute,
                               _ element: Any?,
                               _ constant: CGFloat) -> NSLayoutConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var elementAttribute: NSLayoutConstraint.Attribute
        
        switch attribute {
            
            case .top: elementAttribute = .bottom
            case .bottom: elementAttribute = .top
            case .leading: elementAttribute = .trailing
            case .trailing: elementAttribute = .leading
            default: return NSLayoutConstraint()
        }
        
        return NSLayoutConstraint(item: self,
                                  attribute: attribute,
                                  relatedBy: .equal,
                                  toItem: element,
                                  attribute: elementAttribute,
                                  multiplier: 1,
                                  constant: constant)
    }
    
    func addSubviews(_ views: [UIView]) {
        
        for view in views {
            
            addSubview(view)
        }
    }
}

extension UIColor {
    
    static func fourbankOrange() -> UIColor {
        
        return UIColor(red: 204/255,
                       green: 66/255,
                       blue: 2/255,
                       alpha: 1)
    }
    
    static func fourbankBlue() -> UIColor {
        
        return UIColor(red: 28/255,
                       green: 28/255,
                       blue: 56/255,
                       alpha: 1)
    }
}

extension CGColor {
    
    static func fourbankOrange() -> CGColor {
        
        return CGColor(red: 204/255,
                       green: 66/255,
                       blue: 2/255,
                       alpha: 1)
    }
    
    static func fourbankBlue() -> CGColor {
        
        return CGColor(red: 28/255,
                       green: 28/255,
                       blue: 56/255,
                       alpha: 1)
    }
}
