//
//  Date+Extention.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//
import UIKit

extension Date {
    func getInvoiceDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}
