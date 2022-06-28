//
//  PixView.swift
//  Fourbank
//
//  Created by Josicleison on 12/06/22.
//

import UIKit

class PixView: UIViewController, PixController {
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var pixImageView: UIImageView!
    @IBOutlet weak var pixLabel: UILabel!
    @IBOutlet weak var pixTextField: UITextField!
    
    @IBOutlet weak var contactsLabel: UILabel!
    @IBOutlet weak var contactsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var tabBar: UITabBar!

    var stage: Bool = true
    var pixKeys: [String] = []
    var pixNames: [String] = []
    
    var paymentValue = ""
    var user = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup(user) {result in
            
            switch result {
                
                case .success(let data):
                
                    self.pixKeys = data[1]
                    self.pixNames = data[0]
                    self.contactsCollectionView.reloadData()
                
                case .failure(let error):
            
                    self.alert(messageTitle: "Falha ao carregar dados!", message: "erro: \(error)", buttonTitle: "Ok")
                }
        }
        
        self.contactsCollectionView.delegate = self
        self.contactsCollectionView.dataSource = self
        
        tabBar.delegate = self
        
        contactsCollectionView.register(UINib(nibName: "PixViewCell", bundle: nil), forCellWithReuseIdentifier: "PixViewCell")
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        
        if stage {
            
            if validateTextField(pixTextField.text ?? "") &&
               validateNumber(pixTextField.text ?? "") {
                
                paymentValue = pixTextField.text ?? ""
                stage = false
                
                pixTextField.text = ""
                pixImageView.isHidden = true
                infoLabel.isHidden = false
                contactsLabel.isHidden = false
                contactsCollectionView.isHidden = false
                descriptionLabel.isHidden = false
                pixLabel.text = "Chave:"
                pixTextField.placeholder = "Chave Pix"
            }
        }
        else {
            
            if validateTextField(pixTextField.text ?? ""){
                
                validatePixKey(pixTextField.text ?? "") {result, error in
                    
                    if result {
                        
                        let paymentConfirmView = PaymentConfirmView(nibName: "PaymentConfirmView", bundle: nil)
                        paymentConfirmView.modalPresentationStyle = .fullScreen
                        paymentConfirmView.paymentValue = self.paymentValue
                        paymentConfirmView.receiverKey = self.pixTextField.text ?? ""
                        paymentConfirmView.user = self.user
                        self.present(paymentConfirmView, animated: true, completion: nil)
                    }
                    else {
                        
                        if let error = error {
                            
                            self.alert(messageTitle: "Falha",
                                            message: "Erro: \(error)",
                                            buttonTitle: "Ok")
                        }
                        else {
                            
                            self.alert(messageTitle: "Falha",
                                            message: "Essa chave não foi localizada",
                                            buttonTitle: "Ok")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        if stage {
            
            let pixAreaView = PixAreaView(nibName: "PixAreaView", bundle: nil)
            pixAreaView.modalPresentationStyle = .fullScreen
            pixAreaView.user = user
            present(pixAreaView, animated: true, completion: nil)
        }
        else {
            
            pixTextField.text = ""
            stage = true
            
            pixImageView.isHidden = false
            infoLabel.isHidden = true
            contactsLabel.isHidden = true
            contactsCollectionView.isHidden = true
            descriptionLabel.isHidden = true
            pixLabel.text = "Valor:"
            pixTextField.placeholder = "R$ 0,00"
        }
    }
}

extension PixView: UITabBarDelegate {
    
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

extension PixView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        pixNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: PixViewCell? = contactsCollectionView.dequeueReusableCell(withReuseIdentifier: "PixViewCell", for: indexPath) as? PixViewCell
        
        cell?.setup(pixNames[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        pixTextField.text = pixKeys[indexPath.row]
    }
}
