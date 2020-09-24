//  ContinueShopingVC.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 13/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
import UIKit

class ContinueShopingVC: UIViewController {

    @IBOutlet var btnContinueShoping: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnContinueShoping.layer.cornerRadius = 20
        btnContinueShoping.clipsToBounds = true
    }
 
    @IBAction func clickedContinueShoping(_ sender: Any) {
        for i in 0 ..< self.navigationController!.viewControllers.count {
                  if(self.navigationController?.viewControllers[i].isKind(of: Home.self) == true){
                     self.navigationController!.setNavigationBarHidden(false,animated: false)
                     self.navigationItem.hidesBackButton = true
                     self.navigationController?.popToViewController(self.navigationController!.viewControllers[i] as! Home, animated: true)
                     break;
                  }
               }
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
