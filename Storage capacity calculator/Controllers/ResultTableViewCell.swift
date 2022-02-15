//
//  RezultTableViewCell.swift
//  Storage capacity calculator
//
//  Created by ak77m on 24.10.2020.
//

import UIKit

final class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
