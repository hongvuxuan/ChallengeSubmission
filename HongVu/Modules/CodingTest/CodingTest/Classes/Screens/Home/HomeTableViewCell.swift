//
//  HomeTableViewCell.swift
//  CodingTest
//
//  Created by Hong Vu Xuan on 13/05/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var timestampLabel: UILabel?
    @IBOutlet weak var thumnailImageView: UIImageView?
    @IBOutlet weak var shortDetailsLable: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
