// ItemCell.swift
// DemoSlider
// Created by RAKESH KUSHWAHA on 09/07/20.
// Copyright © 2020 rakesh. All rights reserved.

import UIKit
class ItemCell: UITableViewCell {
    @IBOutlet var viewBG: UIView!
    @IBOutlet var imageitems: UIImageView!
    @IBOutlet var nameItem: UILabel!
    @IBOutlet var widthimg: NSLayoutConstraint!
    
    
    let backColor = UIColor(red: 5.0/255.0, green: 59.0/255.0, blue: 150.0/255.0, alpha: 1.0)


    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = backColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
