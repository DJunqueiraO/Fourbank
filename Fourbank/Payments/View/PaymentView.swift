//
//  PaymentsView.swift
//  Fourbank
//
//  Created by Josicleison on 12/06/22.
//

import UIKit
import SwiftUI

class PaymentView: UIViewController{

    @IBOutlet weak var paymentOptionsTable: UITableView!
    
    var titleOfOption: [String] = ["Código de Barras",
                                   "Pix",
                                   "QR Code"]
    var imageOfOption: [String] = ["barcode",
                                   "pix",
                                   "qrcode"]
    
    var user = ""
    
    @IBOutlet weak var tabBar: UITabBar!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tabBar.delegate = self
        
        paymentOptionsTable.delegate = self
        paymentOptionsTable.dataSource = self
        
        paymentOptionsTable.register(UINib(nibName: "MenuOptionsCell", bundle: nil), forCellReuseIdentifier: "MenuOptionsCell")
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        let homeView = HomeView(nibName: "HomeView", bundle: nil)
        homeView.modalPresentationStyle = .fullScreen
        homeView.user = user
        present(homeView, animated: true, completion: nil)
    }
}

extension PaymentView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleOfOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MenuOptionsCell? = paymentOptionsTable.dequeueReusableCell(withIdentifier: "MenuOptionsCell", for: indexPath) as? MenuOptionsCell
        
        cell?.itemTitleLabel.text = titleOfOption[indexPath.row]
        cell?.itemImage.image = UIImage(named: imageOfOption[indexPath.row])

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
            case 0:
            
                let barCodeView = UIHostingController(rootView: BarCodeView())
                barCodeView.modalPresentationStyle = .pageSheet
                present(barCodeView, animated: true, completion: nil)
            
            case 1:
            
                let pixAreaView = PixAreaView(nibName: "PixAreaView", bundle: nil)
                pixAreaView.modalPresentationStyle = .fullScreen
                pixAreaView.user = user
                present(pixAreaView, animated: true, completion: nil)
            
            default:
            
                let qrCodeView = UIHostingController(rootView: QrCodeView())
                qrCodeView.modalPresentationStyle = .pageSheet
                present(qrCodeView, animated: true, completion: nil)
    
        }
    }
}

extension PaymentView: UITabBarDelegate {
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
