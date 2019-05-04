//
//  zipCodeCell.swift
//  zipCodeSearch
//
//  Created by Jackie Norstrom on 5/4/19.
//  Copyright © 2019 Oblast. All rights reserved.
//

import UIKit

class zipCodeCell: UITableViewCell {
    
    
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    
    var zips: zipCode!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func configureTableCell(zips: zipCode) {
        
        self.zips = zips
        zipCodeLabel.text = self.zips.city.capitalized
        //        signImage.image = UIImage(named: "\(self.signs.signNumber)")
        
    }
    
    
}
