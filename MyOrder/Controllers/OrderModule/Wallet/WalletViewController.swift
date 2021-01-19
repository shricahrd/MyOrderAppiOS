//
//  WalletViewController.swift
//  MyOrder
//
//  Created by MAC-51 on 06/12/20.
//

import UIKit
class WalletViewCell: UITableViewCell {
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var buttonArrow: UIButton!
    @IBOutlet weak var labelTitile: UILabel!
    @IBOutlet weak var labelAmount: UILabel!
    func setUpCellData(aWalletModelList: WalletModelList){
        labelDate.text =  aWalletModelList.fld_wallet_date.orderListDate()
        labelTitile.text = aWalletModelList.fld_reward_narration
        if aWalletModelList.fld_reward_points > aWalletModelList.fld_reward_deduct_points {
            buttonArrow.setBackgroundImage(#imageLiteral(resourceName: "reciveBG"), for: .normal)
            buttonArrow.setImage(#imageLiteral(resourceName: "reciveBGArrow"), for: .normal)
            labelAmount.text = "+ " + aWalletModelList.fld_reward_points.description
        }else {
            buttonArrow.setBackgroundImage(#imageLiteral(resourceName: "sentBG"), for: .normal)
            buttonArrow.setImage(#imageLiteral(resourceName: "sentBGArrow"), for: .normal)
            labelAmount.text = "- " + aWalletModelList.fld_reward_deduct_points.description
        }
        
    }
}
class WalletViewController: BaseViewController {
    var currentPageNo = 0
    let aWalletViewModel = WalletViewModel()
    var aWalletModel = WalletModel()
    @IBOutlet weak var labelAvailablePoints: UILabel!
    @IBOutlet weak var labelEarning: UILabel!
    @IBOutlet weak var labelExpense: UILabel!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.serviceCall()
    }
}
extension WalletViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.aWalletModel.aWalletModelList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletViewCell") as! WalletViewCell
        cell.setUpCellData(aWalletModelList: self.aWalletModel.aWalletModelList[indexPath.row])
        return cell
    }
}
extension WalletViewController {
    func serviceCall(){
        self.showActivity()
        self.aWalletViewModel.aGetWalletListServiceCall(afld_page_no: self.currentPageNo) { (model) in
            self.hideActivity()
            self.aWalletModel = model
            self.labelAvailablePoints.text = self.aWalletModel.total_reward_points.description
            self.labelEarning.text = self.aWalletModel.total_earned.description
            self.labelExpense.text = self.aWalletModel.total_spend.description
            self.tableview.reloadData()
        }  aFailed: { (error) in
            self.hideActivity()
            //self.showAlartWith(message: error!.localizedDescription)
        }
    }
}


