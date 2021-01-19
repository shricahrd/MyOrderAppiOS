//
//  HelpAboutViewModel.swift
//  MyOrder
//
//  Created by sourabh on 02/12/20.
//

import UIKit

typealias HelpAboutSuccess = (_ url: String) -> Void

class HelpAboutViewModel: NSObject {

    func aGetHelpAboutServiceCall(isHelp: Bool,
                                   aHelpAboutSuccess:@escaping  HelpAboutSuccess,
                                   aFailed:@escaping  Failed) {
        ApiService.shared.callServiceWith(apiName: kLegalPages, parameter: nil, methods:  .get) { (result, error) in
            if error == nil {
                let object = result?["page_data"] as? [[String: Any]] ?? []
                if isHelp == false {
                    if let about = object.first!["page_url"] as? String {
                        aHelpAboutSuccess(about)
                    }
                }else {
                    if let help = object.last!["page_url"] as? String {
                        aHelpAboutSuccess(help)
                    }
                }
            }else {
                aFailed(error)
            }
        }
    }
}
