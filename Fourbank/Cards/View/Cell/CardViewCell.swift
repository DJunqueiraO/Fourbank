//
//  CardViewCell.swift
//  Fourbank
//
//  Created by user218968 on 6/16/22.
//

import UIKit

class CardViewCell: UITableViewCell {

    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var clientLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup (cardInfo: [String]) {
        
        clientLabel.text = cardInfo[0]
        cardNumberLabel.text = cardInfo[1]
    }
}
