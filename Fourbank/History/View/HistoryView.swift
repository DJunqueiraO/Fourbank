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
    
    var itens: [[String]] = [["Transferências enviadas", "", ""],
                             ["Dinheiro resgatado", "", ""],
                             ["Transferências recebidas", "", ""]]
    var user = ""
   
    var credited: [String] = []
    var debited: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        APIRequest(user) {user in
            
            if let user = user {
                
                self.credited = self.arrayToStringConverter(user.credited)
                self.debited = self.arrayToStringConverter(user.debited)
            }
        }
        
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

//                    var word = ""
//
//                    for char in data.0 {
//
//                        if char == "#" {
//
//                            print(word)
//                            self.credited.append(word)
//                            word = ""
//                        }
//                        else {
//                            word.append(char)
//                        }
//                    }
//
//                    for char in data.1 {
//
//                        if char == "#" {
//
//                            print(word)
//                            self.debited.append(word)
//                            word = ""
//                        }
//                        else {
//                            word.append(char)
//                        }
//                    }
