//
//  WishlistCell.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 14/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class WishlistCell: UICollectionViewCell {
    
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priseLabel: UILabel!
    @IBOutlet weak var disCountLabel: UILabel!
    @IBOutlet weak var addtoCartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
