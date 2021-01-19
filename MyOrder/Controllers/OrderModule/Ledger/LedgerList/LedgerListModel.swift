//
//  LedgerListModel.swift
//  MyOrder
//
//  Created by sourabh on 31/10/20.
//

import UIKit


class LedgerData: NSObject {
    var paid_amt: Int = 0
    var total_amt: Int = 0
    var balance_amt: Int = 0
    var aLedgerPartyInfo = LedgerPartyInfo()
    var aLedgerSaleData: [LedgerSaleData] = []
    var aLedgerPurchaseData: [LedgerPurchaseData] = []
    var aLedgerPaymentData: [LedgerPaymentData] = []
    override init(){
    }
    init(fromDictionary dictionary: [String: Any],
         aLedgerPartyInfos: LedgerPartyInfo,
         aLedgerSaleDatas: [LedgerSaleData],
         aLedgerPurchaseDatas: [LedgerPurchaseData],
         aLedgerPaymentDatas: [LedgerPaymentData]) {
        
        if let paid_amt = dictionary["paid_amt"] as? Int {
            self.paid_amt = paid_amt
        }
        if let balance_amt = dictionary["balance_amt"] as? Int {
            self.balance_amt = balance_amt
        }
        if let total_amt = dictionary["total_amt"] as? Int {
            self.total_amt = total_amt
        }
        self.aLedgerPartyInfo = aLedgerPartyInfos
        self.aLedgerSaleData = aLedgerSaleDatas
        self.aLedgerPurchaseData = aLedgerPurchaseDatas
        self.aLedgerPaymentData = aLedgerPaymentDatas
    }
    
}
class LedgerPartyInfo: NSObject {
    var business_name = ""
    var owner_name = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let business_name = dictionary["business_name"] as? String {
            self.business_name = business_name
        }
        if let owner_name = dictionary["owner_name"] as? String {
            self.owner_name = owner_name
        }
    }
}
class LedgerSaleData: NSObject {
    var order_date = ""
    var order_no = ""
    var total_product_amt = "0"
    var zoneassign_order_id = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let order_date = dictionary["order_date"] as? String {
            self.order_date = order_date
        }
        if let order_no = dictionary["order_no"] as? String {
            self.order_no = order_no
        }
        if let total_product_amt = dictionary["total_product_amt"] as? String {
            self.total_product_amt = total_product_amt
        }
        if let zoneassign_order_id = dictionary["zoneassign_order_id"] as? String {
            self.zoneassign_order_id = zoneassign_order_id
        }
    }
}
class LedgerPurchaseData: NSObject {
    var order_date = ""
    var order_no = ""
    var total_product_amt = "0"
    var zoneassign_order_id = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let order_date = dictionary["order_date"] as? String {
            self.order_date = order_date
        }
        if let order_no = dictionary["order_no"] as? String {
            self.order_no = order_no
        }
        if let total_product_amt = dictionary["total_product_amt"] as? String {
            self.total_product_amt = total_product_amt
        }
        if let zoneassign_order_id = dictionary["zoneassign_order_id"] as? String {
            self.zoneassign_order_id = zoneassign_order_id
        }
    }
}
class LedgerPaymentData: NSObject {
    var created_at = ""
    var payment_status = ""
    var vendor_payment_amt = 0
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let created_at = dictionary["created_at"] as? String {
            self.created_at = created_at
        }
        if let payment_status = dictionary["payment_status"] as? String {
            self.payment_status = payment_status
        }
        if let vendor_payment_amt = dictionary["vendor_payment_amt"] as? Int {
            self.vendor_payment_amt = vendor_payment_amt
        }
    }
}

