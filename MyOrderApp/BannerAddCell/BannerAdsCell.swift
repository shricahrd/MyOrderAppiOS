//
//  BannerAdsCell.swift
//  Trolleey
//
//  Created by Ivica Technologies on 27/05/20.
//  Copyright © 2020 Brainiuminfotech. All rights reserved.
//

import UIKit

class BannerAdsCell: UICollectionViewCell {

    @IBOutlet weak var bannerAddLabel: UILabel!
    
    @IBOutlet var shadowView: UIView!{
          didSet{
              
              self.shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
              self.shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
              self.shadowView.layer.shadowOpacity = 2.0
              self.shadowView.layer.shadowRadius = 2.0
              self.shadowView.layer.masksToBounds = false
              self.shadowView.layer.cornerRadius = 2.0
          }
      }
    
    @IBOutlet weak var bannerAdsImageView: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
