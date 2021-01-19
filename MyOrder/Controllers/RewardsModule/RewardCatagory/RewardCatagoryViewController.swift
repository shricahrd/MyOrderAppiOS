//
//  RewardCatagoryViewController.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//

import UIKit

class RewardCatagoryViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!

    var aRewardCatagoryViewModel = RewardCatagoryViewModel()
    var aRewardCatagoryModel = RewardCatagoryModel()
    var currentPageNo = 0
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
extension RewardCatagoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aRewardCatagoryModel.aRewardCatagoryList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WearlistCell") as! WearlistCell
        cell.labelName.text = aRewardCatagoryModel.aRewardCatagoryList[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let  aRewardProductListViewController = RewardProductListViewController.getController(story: "Reward")  as? RewardProductListViewController {
            aRewardProductListViewController.rewardCatId = aRewardCatagoryModel.aRewardCatagoryList[indexPath.row].id
            self.navigationController?.pushViewController(aRewardProductListViewController, animated: true)
        }
    }
}
extension RewardCatagoryViewController: UITextFieldDelegate {
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
extension RewardCatagoryViewController {
    func serviceCall(){
        self.showActivity()
        self.aRewardCatagoryViewModel.aGetRewardCatagoryListServiceCall(afld_page_no: self.currentPageNo) { (model) in
            self.hideActivity()
            self.aRewardCatagoryModel = model
            self.tableView.reloadData()
        }  aFailed: { (error) in
            self.hideActivity()
            //self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
