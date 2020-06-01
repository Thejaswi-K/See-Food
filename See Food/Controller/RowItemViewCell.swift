//
//  RowItemViewCell.swift
//  See Food
//
//  Created by Thejaswi Kampalli on 5/29/20.
//  Copyright © 2020 Thejaswi Kampalli. All rights reserved.
//

import UIKit

class RowItemViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
