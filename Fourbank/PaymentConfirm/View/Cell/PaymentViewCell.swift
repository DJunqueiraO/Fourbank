//
//  PaymentInfoCell.swift
//  Fourbank
//
//  Created by Josicleison on 19/06/22.
//

import UIKit

class PaymentViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ paymentInfo: [String]) {
        
        titleLabel.text = paymentInfo[0]
        infoLabel.text = paymentInfo[1]
    }
}
