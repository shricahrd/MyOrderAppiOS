//
//  UITextfield+extra.swift
//  Trolleey
//
//  Created by Ivica Technologies on 21/05/20.
//  Copyright © 2020 Brainiuminfotech. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics



//MARK: UIView designable Methods
@IBDesignable extension UIView
{
    @IBInspectable var borderColor:UIColor?
        {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    /* Created by kotaiah on 28-Sep-2018
     * * Purpose : This method is to add custom stoaryboard property borderWidth.
     */
    @IBInspectable var borderWidth:CGFloat
        {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    /* Created by Kotaiah on 28-Sep-2018
     * * Purpose : This method is to add custom stoaryboard property cornerRadius.
     */
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

private var kAssociationKeyMaxLength: Int = 0
extension UITextField {
    
    /* Created by Kotaiah 1-March-2018
     * * Purpose : This method is to add custom stoaryboard property max length to textfield.
     */
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    /* Created by  kotaiah 1-March-2018
     * * Purpose : This method is to validate max length of textfield.
     */
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}

//MARK: Custom TextFiled class
extension UIView {
class PaddingTextField: UITextField {
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect
    {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y,
                      width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
// shadowRadius
@IBInspectable
var shadowRadius: CGFloat {
    get {
        return layer.shadowRadius
    }
    set {
        layer.shadowRadius = newValue
    }
}

@IBInspectable
var shadowOpacity: Float {
    get {
        return layer.shadowOpacity
    }
    set {
        layer.shadowOpacity = newValue
    }
}

@IBInspectable
var shadowOffset: CGSize {
    get {
        return layer.shadowOffset
    }
    set {
        layer.shadowOffset = newValue
    }
}

@IBInspectable
var shadowColor: UIColor? {
    get {
        if let color = layer.shadowColor {
            return UIColor(cgColor: color)
        }
        return nil
    }
    set {
        if let color = newValue {
            layer.shadowColor = color.cgColor
        } else {
            layer.shadowColor = nil
        }
    }
}

}


extension UIProgressView {
    
    @IBInspectable var barHeight : CGFloat {
        get {
            return transform.d * 2.0
        }
        set {
            // 2.0 Refers to the default height of 2
            let heightScale = newValue / 2.0
            let c = center
            transform = CGAffineTransform(scaleX: 1.0, y: heightScale)
            center = c
        }
    }
}

