
//
//  DescriptionCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 26/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit
import WebKit

class DescriptionCell: UITableViewCell {

    @IBOutlet var viewBg: UIView!
    @IBOutlet var descriptionText: UILabel!
    @IBOutlet weak var webViewDescription: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
