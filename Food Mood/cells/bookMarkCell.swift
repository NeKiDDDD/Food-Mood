//
//  bookMarkCell.swift
//  Food Mood
//
//  Created by Nikita Kuznetsov on 26.05.2023.
//

import UIKit

class bookMarkCell: UITableViewCell {
    
    @IBOutlet weak var nameMark: UILabel!
    @IBOutlet weak var imageMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
