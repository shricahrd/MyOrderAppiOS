//
//  DashboardStokistDistributorVC.swift
//  MyOrder
//
//  Created by sourabh on 06/11/20.
//

import UIKit
class DashboardStokistDistributorVC: BaseViewController
{
    var aDashboardViewModel = DashboardViewModel()
    var aDashboardMenuFacturerVM = DashboardMenuFacturerVM()

    @IBOutlet weak var labelOrderRecives: UILabel!
    @IBOutlet weak var labelCart: UILabel!
    @IBOutlet weak var labelOrderDispatched: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.getSideMenuCatagorys()
        self.labelOrderRecives.text = "ORDER\nRECEIVED\n"
        self.labelCart.text = "CART\n"
        self.labelOrderDispatched.text = "ORDER\nDISPATCHED\n"
    }
    @IBAction func actionOnOrderRevice(_ sender: Any) {
        if let  aOrderListViewController = OrderListViewController.getController(story: "Order")  as? OrderListViewController {
            aOrderListViewController.viewTitle = "Order Received"
            aOrderListViewController.aOrderServiceType = .delivered
            self.goToSideMenuController(centerVC: aOrderListViewController)
        }
    }
    @IBAction func actionOnCart(_ sender: Any) {
        if let  aCartViewController = CartViewController.getController(story: "Dashboard")  as? CartViewController {
            aCartViewController.shouldShowBack = false
            self.goToSideMenuController(centerVC: aCartViewController)
        }
    }
    @IBAction func actionOnOrderDispatched(_ sender: Any) {
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
            self.labelOrderRecives.text = "ORDER\nRECEIVED\n(" + model.order_received.description + ")"
            self.labelCart.text = "CART\n(" + model.cart.description + ")"
            self.labelOrderDispatched.text = "ORDER\nDISPATCHED\n(" + model.order_dispatched.description + ")"
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
