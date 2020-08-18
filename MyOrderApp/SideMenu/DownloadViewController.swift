//
//  DownloadViewController.swift
//  DemoSlider
//
//  Created by RAKESH KUSHWAHA on 09/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit
import  SideMenu


class DownloadViewController: UIViewController {
    
    var menu : SideMenuNavigationController?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .red
        
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: true)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTapMenu(){
             present(menu!,animated: true)
         }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
