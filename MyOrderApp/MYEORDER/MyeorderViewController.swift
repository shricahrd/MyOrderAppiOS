//
//  MyeorderViewController.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 07/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class MyeorderViewController: UIViewController  {
    var screenSize:CGRect=UIScreen.main.bounds
    var screenWidth:CGFloat=0.0
    var screenHeight:CGFloat=0.0
    var arrayCollection = ["Medical", "Wellbeing", "Child Development", "Leave & Fitness Certificates"]
    var arrayimg = ["medicalicon", "wellbeingicon", "childdevelopmenticon", "fitnesscertificatesicon"]
    var imgProfileCell: UIImageView!
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var imgLogo: UIImageView!
    @IBOutlet var viewHeader: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = screenSize.width
        screenHeight = screenSize.height
    }
   

    @IBAction func btnMenuAction(_ sender: Any) {
        
    }
    
}
