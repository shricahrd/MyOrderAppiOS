//  AkAlert.swift

import UIKit

class AkAlert: NSObject {
    private override init() { }
    // MARK: Shared Instance
    static let shared = AkAlert()
    
    func showAlertWith(_ title:String!, message:String!, onVC: UIViewController!) -> Void {
        let alertC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alertC.addAction(okAction)
        onVC.present(alertC, animated: true, completion: nil)
    }
    
  
}
