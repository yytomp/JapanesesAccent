//
//  wordUITableViewCell.swift
//  leftRIghtGame
//
//  Created by Matthew Anning on 17/4/20.
//  Copyright © 2020 Matthew Anning. All rights reserved.
//

import UIKit

class wordUITableViewCell: UITableViewCell {

    @IBOutlet var kanji: UILabel!
    @IBOutlet var hiragana: UILabel!

    @IBOutlet var length: UILabel!
    @IBOutlet var english: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
