//
//  Date+Extention.swift
//  MyOrder
//
//  Created by gwl on 29/10/20.
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
}
