//
//  UIView+Extention.swift
//  MyOrder
//
//  Created by sourabh on 08/10/20.
//

import UIKit
@IBDesignable class BorderView : UIView {
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
        layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
@IBDesignable class BorderButton : UIButton {
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
        layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
extension UIView {
    func makeBottomRounded(){
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 40, height: 40)).cgPath
        self.layer.mask = rectShape
        self.layer.backgroundColor = #colorLiteral(red: 0.1124498621, green: 0.333992064, blue: 0.6623016, alpha: 1)
        makeBottomShadow()
    }
    func makeBottomShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    func shadowWithRadius(aBounds: CGRect? = nil){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: (aBounds == nil ? self.bounds : aBounds)!, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3)
        self.layer.shadowOpacity = 0.08
        self.layer.shadowRadius = 8.0
        self.layoutIfNeeded()
    }
    
}
