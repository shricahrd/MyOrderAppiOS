//
//  ColorSizeListCell.swift
//  MyOrderApp
//
//  Created by Apple on 9/26/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class ColorSizeListCell: UITableViewHeaderFooterView {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var colorlabel: UILabel!
    @IBOutlet weak var colorvalue: UILabel!
    @IBOutlet weak var quantityvalue: UILabel!
    @IBOutlet weak var dropdownSelected: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
}
