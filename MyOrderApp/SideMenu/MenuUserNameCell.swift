//
//  MenuUserNameCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 10/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class MenuUserNameCell: UITableViewCell {
    @IBOutlet var viewBG: UIView!
    @IBOutlet var imagemenuBag: UIImageView!
    @IBOutlet var userName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
