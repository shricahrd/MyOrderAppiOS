//
//  RedeemOrderViewController.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//

import UIKit
class RedeemOrderViewController: BaseViewController {
    @IBOutlet weak var textFieldSearch: UITextField!
    var aRedeemOrderViewModel = RedeemOrderViewModel()
    var currentPageNo = 0
    var isLoading: Bool = false
    @IBOutlet weak var tableView: UITableView!
    var aRedeemOrderModel = RedeemOrderModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.serviceCall()
        self.aSearchProductViewController.aSearchComplition = { object in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.goToSearchResult(text: object)
            }
        }
    }
}
extension RedeemOrderViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if result.contains("\n") { return true}
        if result.count > 0 {
            if let frame = textField.superview?.convert(textField.frame, to: nil) {
                self.showSearchList(top: frame.maxY + 20, text: result)
            }
        }else {
            self.hideSearchList()
        }
        return true
    }
    func goToSearchResult(text: String){
        if let  aProductListViewController = ProductListViewController.getController(story: "Dashboard")  as? ProductListViewController {
            aProductListViewController.searchText = text
            self.navigationController?.pushViewController(aProductListViewController, animated: true)
        }
    }
}
extension RedeemOrderViewController {
    func serviceCall(){
        self.showActivity()
        self.aRedeemOrderViewModel.aGetRedeemListServiceCall(afld_page_no: self.currentPageNo) { (model) in
            self.hideActivity()
            if self.isLoading == true {
                self.aRedeemOrderModel.aRedeemOrders.append(contentsOf: model.aRedeemOrders)
                self.isLoading = false
            }else {
                self.aRedeemOrderModel = model
            }
            self.tableView.reloadData()
        }  aFailed: { (error) in
            self.hideActivity()
            //self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
extension RedeemOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aRedeemOrderModel.aRedeemOrders.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell") as! OrderListCell
        cell.setCellData(aRedeemOrders: aRedeemOrderModel.aRedeemOrders[indexPath.row])
        cell.buttonMore.tag = indexPath.row
        cell.buttonMore.addTarget(self, action: #selector(self.actionOnMore), for: UIControl.Event.touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.y
        if contentOffsetX >= (scrollView.contentSize.height - scrollView.bounds.height) - 20 /* Needed offset */ {
            guard !self.isLoading else { return }
            self.isLoading = true
            self.currentPageNo += 1
            self.serviceCall()
        }
    }
    @objc func actionOnMore(sender: UIButton) {
        if let aRewardOrderDetailsViewController = RewardOrderDetailsViewController.getController(story: "Reward")  as? RewardOrderDetailsViewController {
            aRewardOrderDetailsViewController.aRedeemOrders = aRedeemOrderModel.aRedeemOrders[sender.tag]
            self.navigationController?.pushViewController(aRewardOrderDetailsViewController, animated: true)
        }
    }
}
