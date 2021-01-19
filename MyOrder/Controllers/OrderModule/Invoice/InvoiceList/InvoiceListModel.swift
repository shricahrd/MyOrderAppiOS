//
//  InvoiceListModel.swift
//  MyOrder
//
//  Created by sourabh on 31/10/20.
//

import UIKit

class InvoiceListModel: NSObject {
    var aInvoiceList: [InvoiceList] = []
    var nextPage: Int = 0
    var fld_total_page: Int = 0
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aInvoiceList: [InvoiceList] ) {
        self.aInvoiceList = aInvoiceList
        self.fld_total_page = dictionary["fld_total_page"] as? Int ?? 0
        self.nextPage = dictionary["next_page"] as? Int ?? 0
    }
}

class InvoiceList: NSObject {
    var fld_invoice_no: String = ""
    var fld_order_amt: String = ""
    var fld_order_date: String = ""
    var fld_order_no: String = ""
    var fld_supplier_name: String = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_invoice_no = dictionary["fld_invoice_no"] as? String {
            self.fld_invoice_no = fld_invoice_no
        }
        if let fld_supplier_name = dictionary["fld_supplier_name"] as? String {
            self.fld_supplier_name = fld_supplier_name
        }
        if let fld_order_amt = dictionary["fld_order_amt"] as? String {
            self.fld_order_amt = fld_order_amt
        }
        if let fld_order_date = dictionary["fld_order_date"] as? String {
            self.fld_order_date = fld_order_date
        }
        if let fld_order_no = dictionary["fld_order_no"] as? String {
            self.fld_order_no = fld_order_no
        }
    }
}
