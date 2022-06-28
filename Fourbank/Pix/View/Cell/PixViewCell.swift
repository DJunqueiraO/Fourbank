//
//  contactsCollectionViewCell.swift
//  Fourbank
//
//  Created by Josicleison on 19/06/22.
//

import UIKit

class PixViewCell: UICollectionViewCell {
    
    @IBOutlet weak var initials: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width/2
    }
    
    func setup(_ name: String) {
        
        initials.text = ""
        
        for char in name {
            
            if char.isUppercase {
                
                initials.text?.append(char)
            }
        }
    }
}
