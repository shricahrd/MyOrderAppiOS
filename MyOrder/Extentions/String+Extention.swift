//
//  Date+Extention.swift
//  MyOrder
//
//  Created by sourabh on 29/10/20.
//

import UIKit

extension String {
    func orderListDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from:self)!
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    func withBoldText(boldPartsOfString: Array<String>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let aString = NSMutableAttributedString(string: "", attributes: nonBoldFontAttribute)
        self.components(separatedBy: " ").forEach { obje in
            let boldString = NSMutableAttributedString(string: obje.lowercased() as String, attributes:nonBoldFontAttribute)
            for i in 0 ..< boldPartsOfString.count {
                boldString.addAttributes(boldFontAttribute, range: (obje.lowercased() as NSString).range(of: boldPartsOfString[i].lowercased()))
            }
            let space = NSMutableAttributedString(string: " ", attributes: nonBoldFontAttribute)
            aString.append(boldString)
            aString.append(space)
        }
        return aString
    }
}
