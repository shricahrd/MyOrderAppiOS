//
//  RewardProductListViewController.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//

import UIKit

class RewardProductListViewController: BaseViewController {
  
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var currentPageNo = 0
    var rewardCatId = 0
    var sortBy = 0
    var isLoading: Bool = false
    var aRewardProductListViewModel = RewardProductListViewModel()
    var aRewardProductListModel: [RewardProductListModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
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
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnSort(_ sender: Any) {
        self.showSortby { (index) in
            self.aRewardProductListModel.removeAll()
            self.tableView.reloadData()
            self.currentPageNo = 0
            self.sortBy = index
            self.serviceCall()
        }
    }
}
extension RewardProductListViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.clear
        return 140
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.aRewardProductListModel.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductList") as! ProductList
        cell.selectionStyle = .none
        cell.setUpCellData(aRewardProduct: self.aRewardProductListModel[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let aRewardDetailsViewController = RewardDetailsViewController.getController(story: "Reward")  as? RewardDetailsViewController {
            aRewardDetailsViewController.aRewardProductListModel = self.aRewardProductListModel[indexPath.row]
            self.navigationController?.pushViewController(aRewardDetailsViewController, animated: true)
        }
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
}
extension RewardProductListViewController: UITextFieldDelegate {
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
extension RewardProductListViewController {
    func serviceCall(){
        self.showActivity()
        self.aRewardProductListViewModel.aGetRewardListServiceCall(afld_page_no: self.currentPageNo,
                                                                   aSortBy: self.sortBy,
                                                                   aCatId: self.rewardCatId) { (model) in
            self.hideActivity()
            self.updateUi(aRewardProductListModel: model)
        }  aFailed: { (error) in
            self.hideActivity()
            //self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func updateUi(aRewardProductListModel: [RewardProductListModel]) {
        if self.isLoading == true {
            self.aRewardProductListModel.append(contentsOf: aRewardProductListModel)
            self.isLoading = false
        }else {
            self.aRewardProductListModel = aRewardProductListModel
        }
        self.tableView.reloadData()
    }
}
