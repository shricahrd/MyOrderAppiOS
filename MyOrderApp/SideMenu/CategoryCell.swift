//
//  CategoryCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 10/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet var viewBg: UIView!
    @IBOutlet var name: UILabel!
    @IBOutlet var imageArrow: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
