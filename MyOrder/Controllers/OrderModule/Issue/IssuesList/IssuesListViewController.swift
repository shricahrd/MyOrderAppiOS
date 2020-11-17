//
//  IssuesListViewController.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import UIKit

class IssuesListCell: UITableViewCell {
    @IBOutlet weak var labelTicketID: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageViewIssue: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var viewBorder: UIView!

    func setCellData(aIssueList: IssueList) {
        self.viewBorder.shadowWithRadius()
        let url = URL(string: aIssueList.images)
        self.imageViewIssue.kf.indicatorType = .activity
        self.imageViewIssue.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
        self.labelDate.text = aIssueList.issue_date
        self.labelTitle.text = aIssueList.title
        self.labelStatus.text = aIssueList.status
        self.labelTicketID.text = "Ticket ID: #" + aIssueList.trackId
        self.layoutIfNeeded()
        self.labelStatus.textColor = UIColor(named: "AppGreen")

        if aIssueList.status.lowercased() == "Pending".lowercased() {
            self.labelStatus.textColor = UIColor(named: "AppRed")
        }
    }
}

class IssuesListViewController: BaseViewController {
    
    @IBOutlet weak var tableViewIssue: UITableView!
    var aIssuesListViewModel = IssuesListViewModel()
    var aIssuesListModel = IssuesListModel()
    var productId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.getIssueListServiceCall()
        self.tableViewIssue.separatorColor = UIColor.clear
    }
    @IBAction func actionOnAdd(_ sender: Any) {
        if let aAddIssueViewController = AddIssueViewController.getController(story: "Order")  as? AddIssueViewController {
            aAddIssueViewController.productId = productId
            self.navigationController?.pushViewController(aAddIssueViewController, animated: true)
        }
    }
}
extension IssuesListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aIssuesListModel.aIssueList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssuesListCell") as! IssuesListCell
        cell.setCellData(aIssueList: aIssuesListModel.aIssueList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let  aIssueDetailsViewController = IssueDetailsViewController.getController(story: "Order")  as? IssueDetailsViewController {
            aIssueDetailsViewController.aIssueList = aIssuesListModel.aIssueList[indexPath.row]
            self.navigationController?.pushViewController(aIssueDetailsViewController, animated: true)
        }
    }
    
//
}
extension IssuesListViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.count > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                if let  aProductListViewController = ProductListViewController.getController(story: "Dashboard")  as? ProductListViewController {
                    aProductListViewController.searchText = textField.text!
                    self.navigationController?.pushViewController(aProductListViewController, animated: true)
                }
            }
        }
    }
}
extension IssuesListViewController {
    func getIssueListServiceCall() {
        self.showActivity()
        self.aIssuesListViewModel.getIssueListServiceCall(aOrder_id: self.productId) { (model) in
            self.hideActivity()
            self.aIssuesListModel = model
            self.tableViewIssue.reloadData()
        }  aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
