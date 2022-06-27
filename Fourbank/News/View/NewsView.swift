//
//  ViewController.swift
//  Fourbank
//
//  Created by Josicleison Elves on 01/06/22.
//

import UIKit

class NewsView: UIViewController, ApiViewModel {
    
    @IBOutlet weak var newsView: UITableView!
    
    var coinArray: [String] = []
    var ratesArray: [Rates] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.newsView.delegate = self
        self.newsView.dataSource = self
        self.newsView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: "NewsViewCell")
        
       networkCoins {result, error in
           
            if let result = result {
                
                self.ratesArray = result.0
                self.coinArray = result.1
                
                print("CoinData Ok")
                self.newsView.reloadData()
            }
            else {
                
                print(error!)
            }
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let loginView = LoginView(nibName: "LoginView", bundle: nil)
        loginView.modalPresentationStyle = .fullScreen
        present(loginView, animated: true, completion: nil)
    }
}

extension NewsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ratesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: NewsViewCell? = newsView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as? NewsViewCell
        
        DispatchQueue.main.async {
            cell?.setup(image: self.coinArray[indexPath.row],
                        label: self.coinArray[indexPath.row],
                        rate: self.ratesArray[indexPath.row])
        }
        
        return cell ?? UITableViewCell()
    }
}
