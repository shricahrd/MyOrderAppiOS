//
//  WellcomeViewController.swift
//  MyOrder
//
//  Created by gwl on 08/10/20.
//

import UIKit

class WellcomeViewController: BaseViewController {
    
    @IBOutlet weak var viewBlue: UIView!
    @IBOutlet weak var buttonMenufacturer: UIButton!
    @IBOutlet weak var buttonDistributor: UIButton!
    @IBOutlet weak var buttonRetailer: UIButton!
    @IBOutlet weak var buttonStockist: UIButton!
    @IBOutlet weak var buttonAgent: UIButton!
    
    var aSelectedUserType : UserType = .unknown

    override func viewDidLoad() {
        super.viewDidLoad()
        viewBlue.makeBottomRounded()
       
    }
    @IBAction func actionOnRole(_ sender: UIButton) {
        self.buttonMenufacturer.alpha = 0.7
        self.buttonDistributor.alpha = 0.7
        self.buttonRetailer.alpha = 0.7
        self.buttonStockist.alpha = 0.7
        self.buttonAgent.alpha = 0.7
        switch sender.tag {
        case 1:
            aSelectedUserType = .manufacture
            self.buttonMenufacturer.alpha = 1.0
        case 2:
            aSelectedUserType = .stockist
            self.buttonDistributor.alpha = 1.0
        case 3:
            aSelectedUserType = .distributor
            self.buttonRetailer.alpha = 1.0
        case 4:
            aSelectedUserType = .retailer
            self.buttonStockist.alpha = 1.0
        case 5:
            aSelectedUserType = .agent
            self.buttonAgent.alpha = 1.0
        default:
            aSelectedUserType = .unknown
        }
    }
    @IBAction func actionOnGetStart(_ sender: Any) {
        if aSelectedUserType == .unknown {
            self.showAlartWith(message: SelectRole)
        }else {
            if let aSignUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
                aSignUpViewController.aSelectedUserType = self.aSelectedUserType
                self.navigationController?.pushViewController(aSignUpViewController, animated: true)
            }
        }
    }
    @IBAction func actionOnSignIn(_ sender: Any) {
        if aSelectedUserType == .unknown {
            self.showAlartWith(message: SelectRole)
        }else {
            if let aLoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                aLoginViewController.aSelectedUserType = self.aSelectedUserType
                self.navigationController?.pushViewController(aLoginViewController, animated: true)
            }
        }
    }
}
