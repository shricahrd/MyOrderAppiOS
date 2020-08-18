//  SearchCell.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet var viewBG: UIView!
    @IBOutlet var imageProduct: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productType: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var discountPrice: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
