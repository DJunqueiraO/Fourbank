//
//  PerfilCell.swift
//  Fourbank
//
//  Created by user220265 on 6/17/22.
//

import UIKit

class PerfilCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func perfil(_ value: ) {
        self.titleLabel.text
        self.dataLabel.text
    }
}
