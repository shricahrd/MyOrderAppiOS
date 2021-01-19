//  LeftMenuViewController.swift
//  MyOrder
//
//  Created by sourabh on 11/10/20.
//

import UIKit

class SectionCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
}
class SideMenuCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
}
class SideMenuCellSepration: UITableViewCell {
}
class LeftMenuViewController: UIViewController, FAPanelStateDelegate {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var tableViewMenu: UITableView!
    var aLeftMenuViewModel = LeftMenuViewModel()
    var tableArray: [LeftMenuModel] = []

    override func viewDidLoad() {
        panel?.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableArray = self.aLeftMenuViewModel.getSideMenuObjects()
        self.tableViewMenu.reloadData()
        self.labelName.text = "My E-Order"
    }
    func navigateToindex(object: LeftMenuModel){
        switch object.leftPenalType {
        case .category:
            self.navigateToWearList(id: object.id)
        case .dashboard:
            self.navigateToDashboard()
        case .wishlist:
            self.navigateToWishList()
        case .cart:
            self.navigateToCartList()
        case .myOrders:
            self.navigateToMyOrder()
        case .myProfile:
            self.navigateToProfile()
        case .invoice:
            self.navigateToInvoice()
        case .issues:
            self.navigateToIssues()
        case .ledger:
            self.navigateToLedger()
        case .about:
            self.navigateToAbout()
        case .helpSupport:
            self.navigateToHelp()
        case .referandearn:
            self.navigateToReferAndEarn()
        case .wallet:
            self.navigateToWallet()
        case .reward:
            self.navigateToReward()
        case .redeemOrders:
            self.navigateToRedeemOrder()
        case .rewardCart:
            self.navigateToRedeemCart()
        default:
            debugPrint(object)
        }
    }
    func navigateToDashboard(){
        var  centerVC: BaseViewController = DashboardViewController.getController(story: "Dashboard")  as! DashboardViewController
        if UserModel.shared.aSelectedUserType == .manufacture {
            centerVC = DashboardMenuFacturerVC.getController(story: "Dashboard")  as! DashboardMenuFacturerVC
        }else if UserModel.shared.aSelectedUserType == .stockist ||
                    UserModel.shared.aSelectedUserType == .distributor {
            centerVC = DashboardStokistDistributorVC.getController(story: "Dashboard")  as! DashboardStokistDistributorVC
        }
        let centerNavVC = UINavigationController(rootViewController: centerVC)
        panel?.center(centerNavVC)
    }
    func navigateToWearList(id: Int){
        if let  aWearlistViewcontroller = WearlistViewcontroller.getController(story: "Dashboard")  as? WearlistViewcontroller {
            aWearlistViewcontroller.wearableId = id
            let centerNavVC = UINavigationController(rootViewController: aWearlistViewcontroller)
            panel?.center(centerNavVC)
        }
    }
    func navigateToWishList(){
        if let  aFavoriteViewController = FavoriteViewController.getController(story: "Dashboard")  as? FavoriteViewController {
            let centerNavVC = UINavigationController(rootViewController: aFavoriteViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToCartList(){
        if let  aCartViewController = CartViewController.getController(story: "Dashboard")  as? CartViewController {
            aCartViewController.shouldShowBack = false
            let centerNavVC = UINavigationController(rootViewController: aCartViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToMyOrder(){
        if let  aOrderListViewController = OrderListViewController.getController(story: "Order")  as? OrderListViewController {
            let centerNavVC = UINavigationController(rootViewController: aOrderListViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToInvoice(){
        if let  aInvoiceListViewController = InvoiceListViewController.getController(story: "Order")  as? InvoiceListViewController {
            let centerNavVC = UINavigationController(rootViewController: aInvoiceListViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToIssues(){
        if let  aIssuesListViewController = IssuesListViewController.getController(story: "Order")  as? IssuesListViewController {
            let centerNavVC = UINavigationController(rootViewController: aIssuesListViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToLedger(){
        if let  aLedgerFilterViewController = LedgerFilterViewController.getController(story: "Order")  as? LedgerFilterViewController {
            let centerNavVC = UINavigationController(rootViewController: aLedgerFilterViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToProfile(){
        if let  aProfileViewController = ProfileViewController.getController(story: "Profile")  as? ProfileViewController {
            let centerNavVC = UINavigationController(rootViewController: aProfileViewController)
            panel?.center(centerNavVC)
        }
    }
    
    func navigateToAbout(){
        if let  aHelpAboutViewController = HelpAboutViewController.getController(story: "Order")  as? HelpAboutViewController {
            aHelpAboutViewController.isHelp = false
            let centerNavVC = UINavigationController(rootViewController: aHelpAboutViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToHelp(){
        if let  aHelpAboutViewController = HelpAboutViewController.getController(story: "Order")  as? HelpAboutViewController {
            let centerNavVC = UINavigationController(rootViewController: aHelpAboutViewController)
            panel?.center(centerNavVC)
        }
    }
    
    func navigateToReferAndEarn(){
        if let  aReferAndEarnViewController = ReferAndEarnViewController.getController(story: "Order")  as? ReferAndEarnViewController {
            let centerNavVC = UINavigationController(rootViewController: aReferAndEarnViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToWallet(){
        if let  aWalletViewController = WalletViewController.getController(story: "Order")  as? WalletViewController {
            let centerNavVC = UINavigationController(rootViewController: aWalletViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToReward(){
        if let  aRewardCatagoryViewController = RewardCatagoryViewController.getController(story: "Reward")  as? RewardCatagoryViewController {
            let centerNavVC = UINavigationController(rootViewController: aRewardCatagoryViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToRedeemOrder(){
        if let  aRedeemOrderViewController = RedeemOrderViewController.getController(story: "Reward")  as? RedeemOrderViewController {
            let centerNavVC = UINavigationController(rootViewController: aRedeemOrderViewController)
            panel?.center(centerNavVC)
        }
    }
    func navigateToRedeemCart(){
        if let  aRewardCartViewController = RewardCartViewController.getController(story: "Reward")  as? RewardCartViewController {
            let centerNavVC = UINavigationController(rootViewController: aRewardCartViewController)
            panel?.center(centerNavVC)
        }
    }
    @IBAction func actionOnProfile(_ sender: Any) {
    }
    func leftPanelWillBecomeActive() {
        self.tableArray = self.aLeftMenuViewModel.getSideMenuObjects()
        self.tableViewMenu.reloadData()
    }
}
extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.clear
        return CGFloat(tableArray[indexPath.row].height)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = tableArray[indexPath.row]
        if obj.height == 33 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell") as! SectionCell
            cell.labelName.text = obj.title
            cell.selectionStyle = .none
            return cell
        }else if obj.height == 20 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCellSepration") as! SideMenuCellSepration
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
            cell.labelName.text = tableArray[indexPath.row].title
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = tableArray[indexPath.row]
        if object.isClickable == true {
            self.navigateToindex(object: object)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.tableViewMenu.reloadData()
        }
    }
}
