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
    }
    
    
}
