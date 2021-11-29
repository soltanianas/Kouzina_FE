//
//  DetailsMenuCell.swift
//  Kouzina
//
//  Created by Anil Dhameliya on 21/11/21.
//

import UIKit

class DetailsMenuCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblDescription.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 2)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
