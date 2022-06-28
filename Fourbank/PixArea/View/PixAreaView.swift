//
//  PixAreaView.swift
//  Fourbank
//
//  Created by Pedro Moraes (user220265) on 6/22/22.
//

import UIKit

class PixAreaView: UIViewController {
    
    var titleOfMenu: [String] = ["Transferir", "Registrar"]
    var imageOfMenu: [String] = ["rectangle.portrait.and.arrow.right", "key"]
    var user = ""
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var pixAreaMenuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.delegate = self
        
        pixAreaMenuTableView.delegate = self
        pixAreaMenuTableView.dataSource = self
        
        pixAreaMenuTableView.register(UINib(nibName: "MenuOptionsCell", bundle: nil), forCellReuseIdentifier: "MenuOptionsCell")
    }

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        let paymentView = PaymentView(nibName: "PaymentView", bundle: nil)
        paymentView.modalPresentationStyle = .fullScreen
        paymentView.user = user
        present(paymentView, animated: true, completion: nil)
    }
    
}

extension PixAreaView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleOfMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuOptionsCell? = pixAreaMenuTableView.dequeueReusableCell(withIdentifier: "MenuOptionsCell", for: indexPath) as? MenuOptionsCell
        
        cell?.itemTitleLabel.text = titleOfMenu[indexPath.row]
        cell?.itemImage.image = UIImage(systemName: imageOfMenu[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
            case 0:
            
                let pixView = PixView(nibName: "PixView", bundle: nil)
                pixView.modalPresentationStyle = .fullScreen
                pixView.user = user
                present(pixView, animated: true, completion: nil)
            
            default:
            
                let pixRegisterView = PixRegisterView(nibName: "PixRegisterView", bundle: nil)
                pixRegisterView.modalPresentationStyle = .fullScreen
                pixRegisterView.user = user
                present(pixRegisterView, animated: true, completion: nil)
        }
    }
}

extension PixAreaView: UITabBarDelegate {
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
