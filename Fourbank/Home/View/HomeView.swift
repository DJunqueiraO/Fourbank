//
//  HomeView.swift
//  Fourbank
//
//  Created by Pedro Moraes (user220265) on 6/9/22.
//

import UIKit

class HomeView: UIViewController, HomeController{
    
    @IBOutlet weak var homeOptionsTable: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var accountBalanceLabel: UILabel!
    
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var slashedHideButton: UIButton!
    
    var titleOfOption: [String] = ["Pagamentos",
                                   "Minha Conta",
                                   "Meus Cartões"]
    var imageOfOption: [String] = ["dollarsign.circle",
                                   "note.text",
                                   "creditcard"]
    var user = "",
        accountBalance = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        APIRequest(user) {user in
            
            if let user = user {
                
                self.accountBalance = String(user.accountBalance)
                
                while user.accountBalance >= 1 {
                    
                    self.accountBalanceLabel.text?.append("*")
                }
            }
        }
        
        tabBar.delegate = self
        
        homeOptionsTable.delegate = self
        homeOptionsTable.dataSource = self
        
        homeOptionsTable.register(UINib(nibName: "MenuOptionsCell", bundle: nil), forCellReuseIdentifier: "MenuOptionsCell")
    }
    
    @IBAction func hideButton(_ sender: UIButton) {
        
        sender.isHidden = true
        
        accountBalanceLabel.text = "R$ " + accountBalance
        
        slashedHideButton.isHidden = false
    }
    
    @IBAction func slashedHideButton(_ sender: UIButton) {
        
        sender.isHidden = true
        
        accountBalanceLabel.text = ""
        let balance = Float(accountBalance)
    
        if var balance = balance {
            
            while balance>=1 {
                
                self.accountBalanceLabel.text?.append("*")
                balance /= 10
            }
        }
        
        hideButton.isHidden = false
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        let loginView = LoginView(nibName: "LoginView", bundle: nil)
        loginView.modalPresentationStyle = .fullScreen
        present(loginView, animated: true, completion: nil)
    }
    
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleOfOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MenuOptionsCell? = homeOptionsTable.dequeueReusableCell(withIdentifier: "MenuOptionsCell", for: indexPath) as? MenuOptionsCell
        
        cell?.itemTitleLabel.text = titleOfOption[indexPath.row]
        cell?.itemImage.image = UIImage(systemName: imageOfOption[indexPath.row])

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
            case 0:
            
                let paymentView = PaymentView(nibName: "PaymentView", bundle: nil)
                paymentView.modalPresentationStyle = .fullScreen
                paymentView.user = user
                present(paymentView, animated: true, completion: nil)
            
            case 1:
            
                let historyView = HistoryView(nibName: "HistoryView", bundle: nil)
                historyView.modalPresentationStyle = .fullScreen
                historyView.user = user
                present(historyView, animated: true, completion: nil)
            
            default:
            
                let cardView = CardView(nibName: "CardView", bundle: nil)
                cardView.modalPresentationStyle = .fullScreen
                cardView.user = user
                present(cardView, animated: true, completion: nil)
        }
    }
}

extension HomeView: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let perfilView = PerfilView(nibName: "PerfilView", bundle: nil)
        perfilView.modalPresentationStyle = .fullScreen
        perfilView.user = user
        present(perfilView, animated: true, completion: nil)
    }
}
