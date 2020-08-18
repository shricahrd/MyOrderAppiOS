//
//  IssueListCell.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 22/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class IssueListCell: UITableViewCell {
    @IBOutlet var ticketid: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var titleText: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var statusValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
