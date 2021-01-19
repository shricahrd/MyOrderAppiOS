//
//  RewardProductListViewModel.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//

import UIKit
typealias RewardProductListModelSuccess = (_ model: [RewardProductListModel]) -> Void

class RewardProductListViewModel: NSObject {
    func aGetRewardListServiceCall(afld_page_no: Int,
                                   aSortBy: Int,
                                   aCatId: Int,
                                   aRewardProductListModelSuccess:@escaping  RewardProductListModelSuccess,
                                   aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "fld_page_no":afld_page_no,
                       "fld_sort_by":aSortBy,
                       "fld_rcat_id":aCatId,
                       "fld_panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kRewardProducts, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aRewardProduct = result?["Reward_Product"] as? [[String: Any]] ?? []
                var aRewardProductListModel: [RewardProductListModel] = []
                aRewardProduct.forEach { object in
                    var thumbnail: [Thumbnail] = []
                    if let thumb = object["thumbnail"] as? [[String: Any]] {
                        for subThumb in thumb {
                            thumbnail.append(Thumbnail(aImageUrl: subThumb["image"] as! String))
                        }
                    }
                    aRewardProductListModel.append(RewardProductListModel(fromDictionary: object, aThumbnail: thumbnail))
                }
                aRewardProductListModelSuccess(aRewardProductListModel)
            }else {
                aFailed(error)
            }
        }
    }
}
