//
//  BadgeButton.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import UIKit
class BadgeButton: UIButton {
    var badgeLabel = UILabel()
    var badge: String? {
        didSet {
            addbadgetobutton(badge: badge)
        }
    }
    public var badgeBackgroundColor = UIColor.red {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    public var badgeTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }
    
    public var badgeFont = UIFont.boldSystemFont(ofSize: 11.0) {
        didSet {
            badgeLabel.font = badgeFont
        }
    }
    public var badgeEdgeInsets: UIEdgeInsets? {
        didSet {
            addbadgetobutton(badge: badge)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addbadgetobutton(badge: nil)
    }
    func addbadgetobutton(badge: String?) {
        badgeLabel.text = badge
        badgeLabel.textColor = badgeTextColor
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.font = badgeFont
        badgeLabel.sizeToFit()
        badgeLabel.textAlignment = .center
        let badgeSize = badgeLabel.frame.size
        let height = max(18, Double(badgeSize.height) + 5.0)
        let width = max(height, Double(badgeSize.width) + 10.0)
        var vertical: Double?, horizontal: Double?
        if let badgeInset = self.badgeEdgeInsets {
            vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
            horizontal = Double(badgeInset.left) - Double(badgeInset.right)
            let xAxis = (Double(bounds.size.width) - 10 + horizontal!)
            let yAxis = -(Double(badgeSize.height) / 2) - 10 + vertical!
            badgeLabel.frame = CGRect(x: xAxis, y: yAxis, width: width, height: height)
        } else {
            let xAxis = self.frame.width + CGFloat((width / 2.0))
            let yAxis = CGFloat(-(height / 2.0))
            badgeLabel.frame = CGRect(x: xAxis, y: yAxis, width: CGFloat(width), height: CGFloat(height))
        }
        badgeLabel.layer.cornerRadius = badgeLabel.frame.height/2
        badgeLabel.layer.borderWidth = 1
        badgeLabel.layer.borderColor = UIColor.red.cgColor
        badgeLabel.layer.masksToBounds = true
        addSubview(badgeLabel)
        badgeLabel.isHidden = badge != nil ? false : true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addbadgetobutton(badge: nil)
        fatalError("init(coder:) is not implemented")
    }
}
