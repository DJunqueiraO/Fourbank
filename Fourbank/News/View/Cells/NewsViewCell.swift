//
//  NewsViewCell.swift
//  Fourbank
//
//  Created by Josicleison Elves on 01/06/22.
//

import UIKit

class NewsViewCell: UITableViewCell
{
    @IBOutlet weak var coinRate: UILabel!
    
    @IBOutlet weak var coinLabel: UILabel!
    
    @IBOutlet weak var criptoImage: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        //super.setSelected(selected, animated: animated)
    }
    
    func setup(image: String, label: String, rate: Rates) {
        let rateString = String(format: "%.2f", rate.rate)
        self.coinLabel.text = label
        self.coinRate.text = "US$ \(rateString)"
        self.criptoImage.image = UIImage(named: image)
    }
}
