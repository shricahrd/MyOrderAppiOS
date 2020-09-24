//Created by Amitraj Modi on 02/08/19.
//Copyright © 2018 None. All rights reserved.


import Foundation
import SVProgressHUD

class DIProgressHud {
    
    class func setDIProgressHudProperties(){
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setForegroundColor(UIColorforbarTintColor)
        SVProgressHUD.setRingThickness(4.0)
        //SVProgressHUD.setRingRadius(40.0)
    }

    class func show(){
        DispatchQueue.main.async {
            SVProgressHUD.show()
            AppDelegate.shared.window?.rootViewController?.view.isUserInteractionEnabled = false
        }
    }

    class func hide(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            AppDelegate.shared.window?.rootViewController?.view.isUserInteractionEnabled = true
        }
    }
    
}
