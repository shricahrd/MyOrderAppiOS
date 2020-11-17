//
//  InvoiceListViewModel.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import Foundation
typealias InvoiceListModelSuccess = (_ model: InvoiceListModel) -> Void

class InvoiceListViewModel: NSObject {
    func aGetInvoiceListServiceCall(afld_page_no: Int,
                                    aInvoiceListModelSuccess:@escaping  InvoiceListModelSuccess,
                                   aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "fld_order_type": 0,
                       "fld_page_no":afld_page_no,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kOrderInvoiceList, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["order_invoice_data"] as? [[String: Any]] ?? []
                var aInvoiceList: [InvoiceList] = []
                object.forEach { invoice in
                    aInvoiceList.append(InvoiceList(fromDictionary: invoice))
                }
                let invoiceL = InvoiceListModel(fromDictionary: result!, aInvoiceList: aInvoiceList)
                aInvoiceListModelSuccess(invoiceL)
            }else {
                aFailed(error)
            }
        }
    }
}
