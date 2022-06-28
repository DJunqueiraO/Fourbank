//
//  CardView.swift
//  Fourbank
//
//  Created by Josicleison on 11/06/22.
//

import UIKit

class CardView: UIViewController, CardController {
    
    @IBOutlet weak var tabBar: UITabBar!

    @IBOutlet weak var cardTableView: UITableView!
    
    let cardTitle: [String] = ["Cartão de Crédito", "Cartão de Débito"]
    
    var cardDescription: [[String]] = []
    
    var user = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tabBar.delegate = self
        
        APIrequest {users in
            
            if let users = users {
                
                if let cardData = self.cardData(self.user,
                                                users) {
                    
                    self.cardDescription = [cardData]
                    self.cardTableView.reloadData()
                }
            }
        }
        
        cardTableView.dataSource = self
        cardTableView.delegate = self
        cardTableView.register(UINib(nibName: "CardViewCell", bundle: nil), forCellReuseIdentifier: "CardViewCell")
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        let homeView = HomeView(nibName: "HomeView", bundle: nil)
        homeView.modalPresentationStyle = .fullScreen
        homeView.user = user
        present(homeView, animated: true, completion: nil)
    }
}

extension CardView: UITableViewDelegate, UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        cardDescription.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CardViewCell? = cardTableView.dequeueReusableCell(withIdentifier: "CardViewCell", for: indexPath) as? CardViewCell
        
        cell?.cardLabel.text = cardTitle[indexPath.row]
        cell?.setup(cardInfo: cardDescription[indexPath.row])

        return cell ?? UITableViewCell()
    }
}

extension CardView: UITabBarDelegate {
    
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
