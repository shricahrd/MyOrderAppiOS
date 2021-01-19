//
//  IssuesListViewController.swift
//  MyOrder
//
//  Created by sourabh on 31/10/20.
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
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var buttonAdd: UIButton!
    var aIssuesListViewModel = IssuesListViewModel()
    var aIssuesListModel = IssuesListModel()
    var productId: String = ""
    var aOrderServiceType: OrderServiceType = .myorder
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        if self.aOrderServiceType != .myorder {
            self.buttonAdd.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.getIssueListServiceCall()
        self.tableViewIssue.separatorColor = UIColor.clear
        self.aSearchProductViewController.aSearchComplition = { object in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.goToSearchResult(text: object)
            }
        }
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
