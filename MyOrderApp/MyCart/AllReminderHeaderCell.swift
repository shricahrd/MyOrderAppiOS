//
//  AllReminderHeaderCell.swift
//  PatientAppNew
//
//  Created by Doctor Insta on 6/25/18.
//  Copyright © 2018 Doctor Insta. All rights reserved.
//

import UIKit

class AllReminderHeaderCell: UITableViewHeaderFooterView {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var dose: UILabel!
    @IBOutlet weak var reminderTimeDay: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    
    @IBOutlet weak var bottomConstarint: NSLayoutConstraint!
    
    @IBOutlet weak var timefromTop: NSLayoutConstraint!
    @IBOutlet weak var timerBottom: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
