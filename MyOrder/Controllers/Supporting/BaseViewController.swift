//
//  BaseViewController.swift
//  MyOrder
//
//  Created by sourabh on 08/10/20.
//

import UIKit
class BaseViewController: UIViewController {
    var aLoaderViewController =  LoaderViewController()
    var aSortbyViewController = SortbyViewController()
    var aSearchProductViewController = SearchProductViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        aSearchProductViewController = (SearchProductViewController.getController(story: "Dashboard")  as? SearchProductViewController)!
    }
    func showAlartWith(title: String = "Alert", message: String, complition: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: complition))
        self.present(alert, animated: true, completion: nil)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func showActivity(){
        aLoaderViewController = (LoaderViewController.getController(story: "Main")  as? LoaderViewController)!
        UIApplication.topViewController { (controller) in
            self.aLoaderViewController.initializeController(parent: controller)
        }
    }
    func hideActivity(){
        self.aLoaderViewController.removeSelfFromSuper {}
    }
    func showSortby(finished: @escaping SortbyComplition){
        aSortbyViewController = (SortbyViewController.getController(story: "Dashboard")  as? SortbyViewController)!
        UIApplication.topViewController { (controller) in
            self.aSortbyViewController.initializeController(parent: controller, finished: finished)
        }
    }
    func showSearchList(top: CGFloat, text: String){
        UIApplication.topViewController { (controller) in
            self.aSearchProductViewController.initializeController(parent: controller, top: top, text: text)
        }
    }
    func hideSearchList(){
        DispatchQueue.main.async {
            self.aSearchProductViewController.removeSelfFromSuper {}
        }
    }
    
    
}
extension BaseViewController {
    func addTitleImage(){
        self.navigationController?.navigationBar.isHidden = false
        let logoButton = UIButton()
        logoButton.setImage(UIImage(named: "titleLogo"), for: .normal)
        logoButton.addTarget(self, action: #selector(self.actionOnLogo), for: UIControl.Event.touchUpInside)

//        let logo = UIImage(named: "titleLogo")
//        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = logoButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    func addLeftBarButton(imageName: String = "sidemenuicon" ) {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 5, width: 50, height: 50)
        button.setImage(UIImage(named: imageName), for: UIControl.State.normal)
        if imageName != "nil" {
            button.addTarget(self, action: #selector(self.actionOnLeftIcon), for: UIControl.Event.touchUpInside)
        }
        // button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    func addRightBarButton(imageName: String = "cardIcon" ) {
        if UserModel.shared.aSelectedUserType != .manufacture {
            let button: BadgeButton = BadgeButton()
            
            if ((self as? RewardCatagoryViewController) != nil ||
                    (self as? RewardProductListViewController) != nil ||
                    (self as? RewardDetailsViewController) != nil ||
                (self as? RedeemOrderViewController) != nil
            ) {
                button.badge = nil
            }
            else {
                button.badge = UserModel.shared.aCartTotalCount == 0 ? nil : UserModel.shared.aCartTotalCount.description
            }
            button.setImage(UIImage(named: imageName), for: UIControl.State.normal)
            button.addTarget(self, action: #selector(self.actionOnRightIcon), for: UIControl.Event.touchUpInside)
            // button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
            let barButton = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = barButton
        }
    }
    func addSideMenu(){
        var  centerVC: BaseViewController = DashboardViewController.getController(story: "Dashboard")  as! DashboardViewController
        if UserModel.shared.aSelectedUserType == .manufacture {
            centerVC = DashboardMenuFacturerVC.getController(story: "Dashboard")  as! DashboardMenuFacturerVC
        }else if UserModel.shared.aSelectedUserType == .stockist ||
                    UserModel.shared.aSelectedUserType == .distributor {
            centerVC = DashboardStokistDistributorVC.getController(story: "Dashboard")  as! DashboardStokistDistributorVC
        }
       
        
        let  leftMenuVC = LeftMenuViewController.getController(story: "Dashboard")  as! LeftMenuViewController
        let centerNavVC = UINavigationController(rootViewController: centerVC)
        let rootController: FAPanelController =  FAPanelController()
        rootController.configs.leftPanelWidth = centerVC.view.frame.size.width - 70
        rootController.configs.bounceOnRightPanelOpen = false
        let vs = rootController.center(centerNavVC).left(leftMenuVC)
        UIApplication.shared.windows.first?.rootViewController = vs
    }
    
    func goToSideMenuController(centerVC: BaseViewController){
        let  leftMenuVC = LeftMenuViewController.getController(story: "Dashboard")  as! LeftMenuViewController
        let centerNavVC = UINavigationController(rootViewController: centerVC)
        let rootController: FAPanelController =  FAPanelController()
        rootController.configs.leftPanelWidth = centerVC.view.frame.size.width - 70
        rootController.configs.bounceOnRightPanelOpen = false
        let vs = rootController.center(centerNavVC).left(leftMenuVC)
        UIApplication.shared.windows.first?.rootViewController = vs
    }
    
    @objc func actionOnLogo() {
        DispatchQueue.main.async {
            self.aSearchProductViewController.removeSelfFromSuper {
                self.addSideMenu()
            }
        }
    }
    @objc func actionOnLeftIcon() {
        DispatchQueue.main.async {
            self.aSearchProductViewController.removeSelfFromSuper {
                self.panel?.openLeft(animated: true)
            }
        }
    }
    @objc func actionOnRightIcon() {
        DispatchQueue.main.async {
            
            if ((self as? RewardCatagoryViewController) != nil ||
                    (self as? RewardProductListViewController) != nil ||
                    (self as? RewardDetailsViewController) != nil ||
                (self as? RedeemOrderViewController) != nil
            ) {
                self.aSearchProductViewController.removeSelfFromSuper {
                    if let  aRewardCartViewController = RewardCartViewController.getController(story: "Reward")  as? RewardCartViewController {
                        self.navigationController?.pushViewController(aRewardCartViewController, animated: true)
                    }
                }
            }else {
                self.aSearchProductViewController.removeSelfFromSuper {
                    if let  aCartViewController = CartViewController.getController(story: "Dashboard")  as? CartViewController {
                        self.navigationController?.pushViewController(aCartViewController, animated: true)
                    }
                }
            }
        }
    }
}
extension UIViewController {
    static func getController(story: String) -> UIViewController {
        let storyBoard = UIStoryboard.init(name: story, bundle: nil)
        return (storyBoard.instantiateViewController(withIdentifier: String(self.className)))
    }
    static var className: String {
        return NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
}