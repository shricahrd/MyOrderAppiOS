//
//  AddIssueViewModel.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import UIKit
class AddIssueViewModel: NSObject {
    func submitIssueServiceCall(title: String,
                                content: String,
                                order_id: Int,
                                aAttechment: UIImage,
                                aAddDefultAddressSuccess: @escaping AddDefultAddressSuccess,
                                aFailed: @escaping Failed) {
        var jsonReq: [String : Any] = [:]
        if order_id == 0 {
            jsonReq = ["title": title,
                          "content": content,
                          "user_id": UserModel.shared.fld_user_id,
                          "panel_type": UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        }else {
            jsonReq = ["title": title,
                       "content": content,
                       "order_id": order_id,
                       "user_id": UserModel.shared.fld_user_id,
                       "panel_type": UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        }
        let imgData = aAttechment.jpegData(compressionQuality: 1)
        ApiService.shared.uploadImageServiceCall(image: imgData!, apiName: order_id == 0 ? kTicketAdd : kIssuesAdd, fileName: "images", parameter: jsonReq) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                aAddDefultAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
}
