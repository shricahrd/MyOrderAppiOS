//  ApplyCell.swift/Users/apple/Documents/MyOrderApp/MyOrderApp.xcodeproj
//  MyOrderApp
//  Created by Apple on 9/10/20.
//  Copyright © 2020 rakesh. All rights reserved.


import UIKit
class ApplyCell: UITableViewCell {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var couponTextField: UITextField!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var totalAmountBg: UIView!
    @IBOutlet weak var totalQuantity: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var discountAmount: UILabel!
    @IBOutlet weak var netAmount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

   
}
