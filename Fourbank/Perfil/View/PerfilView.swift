//
//  PerfilView.swift
//  Fourbank
//
//  Created by Pedro Moraes (user220265) on 6/14/22.
//

import UIKit

class PerfilView: PerfilViewModel {

    @IBOutlet weak var tabBarNavigation: UITabBar!
    @IBOutlet weak var perfilTableView: UITableView!
    
    @IBOutlet weak var dataModifyStackView: UIStackView!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    
    var user = ""
    var perfilData: [[String]] = []
    var dataToModify: Int?
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        APIRequest(user) {user in
            
            if let user = user {
                
                self.perfilData = self.perfilDataUnwraper(user)
                self.perfilTableView.reloadData()
            }
        }
        
        tabBarNavigation.delegate = self
        
        perfilTableView.delegate = self
        perfilTableView.dataSource = self
        
        perfilTableView.register(UINib(nibName: "PerfilViewCell", bundle: nil), forCellReuseIdentifier: "PerfilViewCell")
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        let homeView = HomeView(nibName: "HomeView", bundle: nil)
        homeView.modalPresentationStyle = .fullScreen
        homeView.user = user
        present(homeView, animated: true, completion: nil)
    }
    
    @IBAction func putDataButton(_ sender: UIButton) {
        
        if let parameters = putOnAPI(user,
                                     dataToModify ?? 0,
                                     dataTextField.text ?? "") {
            APIPut(user, parameters)
            
            self.alert(messageTitle: "Sucesso",
                       message: "Dado cadastrado com sucesso",
                       buttonTitle: "Ok")
            print("Success")
            
            APIRequest(user) {user in
                
                if let user = user {
                    
                    self.perfilData = self.perfilDataUnwraper(user)
                    self.perfilTableView.reloadData()
                }
            }
        }
    }
}

extension PerfilView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return perfilData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let perfilViewCell: PerfilViewCell? = perfilTableView.dequeueReusableCell(withIdentifier: "PerfilViewCell", for: indexPath) as? PerfilViewCell
        perfilViewCell?.setup(perfilData: perfilData[indexPath.row])
        return perfilViewCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataModifyStackView.isHidden = false
        dataToModify = indexPath.row
        dataLabel.text = "Alterar " + perfilData[indexPath.row][0]
    }
}

extension PerfilView: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let homeView = HomeView(nibName: "HomeView", bundle: nil)
        homeView.modalPresentationStyle = .fullScreen
        homeView.user = user
        present(homeView, animated: true, completion: nil)
    }
}
