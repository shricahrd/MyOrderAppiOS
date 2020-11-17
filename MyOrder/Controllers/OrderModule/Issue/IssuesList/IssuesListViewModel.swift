//
//  IssuesListViewModel.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import Foundation
typealias IssuesListModelSuccess = (_ model: IssuesListModel) -> Void

class IssuesListViewModel: NSObject {
    func getIssueListServiceCall(aOrder_id: Int,
                                    aIssuesListModelSuccess:@escaping  IssuesListModelSuccess,
                                   aFailed:@escaping  Failed) {
        
        var jsonReq: [String : Any] = [:]
        if aOrder_id == 0 {
            jsonReq = ["user_id":UserModel.shared.fld_user_id,
                          "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        }else {
            jsonReq = ["user_id":UserModel.shared.fld_user_id,
                          "order_id": aOrder_id,
                          "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        }
        ApiService.shared.callServiceWith(apiName: aOrder_id == 0 ? kTicketList : kIssuesList, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["data"] as? [[String: Any]] ?? []
                var aIssueList: [IssueList] = []
                object.forEach { issue in
                    aIssueList.append(IssueList(fromDictionary: issue))
                }
                let invoiceL = IssuesListModel(aIssueList: aIssueList)
                aIssuesListModelSuccess(invoiceL)
            }else {
                aFailed(error)
            }
        }
    }
}
