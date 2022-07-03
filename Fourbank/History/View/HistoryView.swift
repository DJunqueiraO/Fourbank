//
//  BillsView.swift
//  Fourbank
//
//  Created by Josicleison on 10/06/22.
//

import UIKit

class HistoryView: UIViewController, HistoryViewModel {
    
    @IBOutlet weak var paymentHistoryTableCredited: UITableView!
    @IBOutlet weak var paymentHistoryTableDebited: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var accountBalance: UILabel!
    
    @IBOutlet weak var savings: UILabel!
    
    @IBOutlet weak var yield: UILabel!
    
    var user = ""
   
    var credited: [String] = []
    var debited: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        APIRequest(user) {user in self.loadData(user)}
        
        tabBar.delegate = self
        
        paymentHistoryTableCredited.delegate = self
        paymentHistoryTableCredited.dataSource = self
        
        paymentHistoryTableCredited.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        
        paymentHistoryTableDebited.delegate = self
        paymentHistoryTableDebited.dataSource = self
        
        paymentHistoryTableDebited.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        let homeView = HomeView(nibName: "HomeView", bundle: nil)
        homeView.modalPresentationStyle = .fullScreen
        homeView.user = user
        present(homeView, animated: true, completion: nil)
    }
}

extension HistoryView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == paymentHistoryTableCredited {
            
            return credited.count
        }
        else {
            
            return debited.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == paymentHistoryTableCredited {
            
            let cellCredited: HistoryCell? = paymentHistoryTableCredited.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell
            
            cellCredited?.descriptionLabel.text = credited[indexPath.row]
            
            return cellCredited ?? UITableViewCell()
        }
        else {
                
            let cellDebited: HistoryCell? = paymentHistoryTableDebited.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell
            
            cellDebited?.descriptionLabel.text = debited[indexPath.row]
            
            return cellDebited ?? UITableViewCell()
        }
    }
}

extension HistoryView: UITabBarDelegate {
    
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

extension HistoryView {
    
    func loadData(_ user: User?) {
        
        if let user = user {
            
            self.accountBalance.text = "R$ \(String(user.accountBalance)),00"
            
            self.savings.text = "R$ \(String(user.accountBalance)),00"
            
            if user.accountBalance > 0 {
                
                self.yield.textColor = .systemGreen
                self.yield.text = "+R$ \(String(Float(user.accountBalance)*0.005))0 este mes"
            }
            
            self.credited = self.arrayToStringConverter(user.credited)
            self.debited = self.arrayToStringConverter(user.debited)
            
            self.paymentHistoryTableCredited.reloadData()
            self.paymentHistoryTableDebited.reloadData()
        }
    }
}
