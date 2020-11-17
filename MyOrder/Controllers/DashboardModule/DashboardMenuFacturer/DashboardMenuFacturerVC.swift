//
//  DashboardMenuFacturerVC.swift
//  MyOrder
//
//  Created by gwl on 06/11/20.
//

import UIKit

class DashboardMenuFacturerVC: BaseViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
}
