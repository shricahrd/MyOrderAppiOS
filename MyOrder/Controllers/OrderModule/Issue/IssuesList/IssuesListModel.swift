//
//  IssuesListModel.swift
//  MyOrder
//
//  Created by sourabh on 31/10/20.
//

import UIKit

class IssuesListModel: NSObject {
    var aIssueList : [IssueList] = []
    override init(){
    }
    init(aIssueList: [IssueList]) {
        self.aIssueList = aIssueList
    }
}
class IssueList: NSObject {
    var content: String = ""
    var images: String = ""
    var order_id: Int = 0
    var status: String = ""
    var title: String = ""
    var trackId: String = ""
    var issue_date: String = ""
   
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let content = dictionary["content"] as? String {
            self.content = content
        }
        if let images = dictionary["images"] as? String {
            self.images = images
        }
        if let order_id = dictionary["order_id"] as? Int {
            self.order_id = order_id
        }
        if let status = dictionary["status"] as? String {
            self.status = status
        }
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        if let trackId = dictionary["id"] as? Int {
            self.trackId = trackId.description
        }
        if let issue_date = dictionary["issue_date"] as? String {
            self.issue_date = issue_date
        }
    }
}
