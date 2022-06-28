//
//  PerfilViewCell.swift
//  Fourbank
//
//  Created by user220265 on 6/21/22.
//

import UIKit

class PerfilViewCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(perfilData: [String]) {

            dataLabel.text = "\(perfilData[0]) \(perfilData[1])"
    }
}
