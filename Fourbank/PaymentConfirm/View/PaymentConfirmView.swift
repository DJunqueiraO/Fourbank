//
//  PaymentConfirmView.swift
//  Fourbank
//
//  Created by Josicleison on 19/06/22.
//

import UIKit

class PaymentConfirmView: UIViewController, PaymentConfirmViewModel {

    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var paymentInfoTableView: UITableView!
    
    var paymentInfo: [[String]] = []
    
    var paymentValue = ""
    var receiverKey = ""
    var user = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        APIFullRequest {users in
            
            if let users = users {
                
                if let paymentReceiverData = self.paymentReceiverData(self.paymentValue,
                                                                      self.receiverKey,
                                                                      users) {
                    self.paymentInfo = paymentReceiverData
                    self.paymentInfoTableView.reloadData()
                }
            }
        }
        
        paymentInfoTableView.dataSource = self
        paymentInfoTableView.delegate = self
        
        tabBar.delegate = self
        
        paymentInfoTableView.register(UINib(nibName: "PaymentViewCell", bundle: nil), forCellReuseIdentifier: "PaymentViewCell")
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        APIFullRequest {users in
            
            if let users = users {
                
                self.payment(Int(self.paymentValue) ?? 0,
                                self.user,
                                self.receiverKey,
                                users)
                    
                let homeView = HomeView(nibName: "HomeView", bundle: nil)
                homeView.modalPresentationStyle = .fullScreen
                homeView.user = self.user
                self.present(homeView, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        let pixView = PixView(nibName: "PixView", bundle: nil)
        pixView.modalPresentationStyle = .fullScreen
        pixView.user = user
        present(pixView, animated: true, completion: nil)
    }
}

extension PaymentConfirmView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        paymentInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PaymentViewCell? = paymentInfoTableView.dequeueReusableCell(withIdentifier: "PaymentViewCell", for: indexPath) as? PaymentViewCell
        
        cell?.setup(paymentInfo[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}

extension PaymentConfirmView: UITabBarDelegate {
    
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
