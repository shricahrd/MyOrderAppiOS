//
//  RegistationViewModels.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 04/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class RegistationViewModels: BaseCommand {
    
   // class LoginCommand: BaseCommand {
        var name : String?
        var email : String?
        var password :String?
        var contact_number : String?
        
        
        init(name: String?, email: String?,password:String?,contact_number:String) {
            self.name = name
            self.email = email
            self.password = password
            self.contact_number = contact_number
            
        }
        
        override func validate(completion: @escaping(Bool, String?) -> Void) {
            
            if(self.name == nil || self.name?.count == 0){
                completion(false, "Please enter user id")
            
            } else if(self.isValidEmail(emailStr: self.email)==false){
                completion(false, "Please enter valid email address")

                
            } else if(self.password == nil || self.password?.count == 0){
                completion(false, "Please enter password")
            }else{
                completion(true, "")
            }
        }
        
        func isValidEmail(emailStr:String?) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: emailStr)
        }
   // }


}
