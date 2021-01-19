//
//  DashboardMenuFacturerVC.swift
//  MyOrder
//
//  Created by sourabh on 06/11/20.
//

import UIKit

class DashboardMenuFacturerVC: BaseViewController
{
    var aDashboardViewModel = DashboardViewModel()
    var aDashboardMenuFacturerVM = DashboardMenuFacturerVM()
    @IBOutlet weak var labelOrderRecive: UILabel!
    @IBOutlet weak var labelOrderDispatch: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.getSideMenuCatagorys()
        self.labelOrderRecive.text = "ORDER\nRECEIVED\n"
        self.labelOrderDispatch.text = "ORDER\nDISPATCHED\n"
        
    }
    @IBAction func actionOnOrderRecive(_ sender: Any) {
        if let  aOrderListViewController = OrderListViewController.getController(story: "Order")  as? OrderListViewController {
            aOrderListViewController.viewTitle = "Order Received"
            aOrderListViewController.aOrderServiceType = .delivered
            self.goToSideMenuController(centerVC: aOrderListViewController)
        }
    }
    @IBAction func actionOnOrderDispatch(_ sender: Any) {
        if let  aOrderListViewController = OrderListViewController.getController(story: "Order")  as? OrderListViewController {
            aOrderListViewController.aOrderServiceType = .dispatched
            aOrderListViewController.viewTitle = "Order Dispatched"
            self.goToSideMenuController(centerVC: aOrderListViewController)
        }
    }
    func getSideMenuCatagorys() {
        self.showActivity()
        self.aDashboardViewModel.getSideMenuCatagorys { (model) in
            self.hideActivity()
            self.dashboardServiceCall()
        } aFailed: { (error) in
            self.hideActivity()
            self.dashboardServiceCall()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func dashboardServiceCall(){
        self.showActivity()
        self.aDashboardMenuFacturerVM.dasshboardServiceCall {(model) in
            self.hideActivity()
            self.labelOrderRecive.text = "ORDER\nRECEIVED\n(" + model.order_received.description + ")"
            self.labelOrderDispatch.text = "ORDER\nDISPATCHED\n(" + model.order_dispatched.description + ")"
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
