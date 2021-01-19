//
//  Usermodel.swift
//  MyOrder
//
//  Created by sourabh on 13/10/20.
//

import UIKit

final class UserModel: NSObject {
    static var shared: UserModel = UserModel()
    var aSelectedUserType : UserType = .unknown
    var aCartTotalCount : Int = 0
    var fld_user_id : Int = 0
    var fld_user_name : String = ""
    var fld_user_email : String = ""
    var fld_user_phone : String = ""
    var aSideMenuCatagorys: [Catagorys] = []
    private override init() {
        super.init()
    }
    func setUserModel(aLoginModel: LoginModel, aUserType: UserType){
        self.aSelectedUserType = aUserType
        self.fld_user_id = aLoginModel.fld_user_id
        self.fld_user_name = aLoginModel.fld_user_name
        self.fld_user_email = aLoginModel.fld_user_email
        self.fld_user_phone = aLoginModel.fld_user_phone
    }
}
