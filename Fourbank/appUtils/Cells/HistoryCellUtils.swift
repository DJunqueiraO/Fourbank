//
//  PaymentHistoryCell.swift
//  Fourbank
//
//  Created by Josicleison on 10/06/22.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setup(_ itens: [String]) {
//
//        titleLabel.text = itens[0]
//        descriptionLabel.text = itens[1]
//        dateLabel.text = itens[2]
//    }
}
