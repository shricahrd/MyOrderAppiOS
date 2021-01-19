//
//  WearlistViewcontroller.swift
//  MyOrder
//
//  Created by sourabh on 11/10/20.
//

import UIKit



class WearlistCell: UITableViewCell{
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageExpand: UIImageView!
}
class WearlistSubCell: UITableViewCell{
    @IBOutlet weak var labelName: UILabel!
}
class WearlistViewcontroller: BaseViewController {
    @IBOutlet weak var tableViewWearList: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    var tableArray : [Catagorys] = []
    var wearableId: Int = 0
    let aWearlistViewModel = WearlistViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        self.wearServiceCall(isHadding: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.aSearchProductViewController.aSearchComplition = { object in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.goToSearchResult(text: object)
            }
        }
    }
}
extension WearlistViewcontroller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WearlistCell") as! WearlistCell
        let cellsub = tableView.dequeueReusableCell(withIdentifier: "WearlistSubCell") as! WearlistSubCell
        let obj = tableArray[indexPath.row]
        if obj.isHeading == true {
            cell.labelName.text = obj.name
            cell.imageExpand.image = UIImage(named: obj.leftImageName)
            return cell
        }else {
            cellsub.labelName.text = obj.name
            //cellsub.selectionStyle = .none
            return cellsub
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            let obj = self.tableArray[indexPath.row]
            if obj.isHeading == true {
                self.getSubCatagoryFor(catId: obj.id, number: obj.number)
            }else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let  aProductListViewController = ProductListViewController.getController(story: "Dashboard")  as? ProductListViewController {
                        aProductListViewController.catagoryId = obj.id
                        self.navigationController?.pushViewController(aProductListViewController, animated: true)
                    }
                }
            }
        }
    }
}
extension WearlistViewcontroller: UITextFieldDelegate {
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
extension WearlistViewcontroller {
    func wearServiceCall(isHadding: Bool){
        self.showActivity()
        self.aWearlistViewModel.getCatagorys(afld_page_no: 0, fld_cat_id: self.wearableId) { (model) in
            self.hideActivity()
            self.tableArray = model.aCatagorys
            self.tableViewWearList.reloadData()
        }aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func getSubCatagoryFor(catId: Int, number:Int){
        self.showActivity()
        self.aWearlistViewModel.getSubCatagorys(afld_page_no: 0,
                                                fld_cat_id: catId,
                                                nuber: number) { (models) in
            self.hideActivity()
            var newArray: [Catagorys] = self.tableArray.filter { $0.isHeading == true }
            for new in newArray {
                if new.number == number && models.count > 0 {
                    new.leftImageName = "minus"
                }else {
                    new.leftImageName = "plus"
                }
            }
            for model in models {
                newArray.insert(model, at: number)
            }
            self.tableArray = newArray
            self.tableViewWearList.reloadData()
        }aFailed: { (error) in
            let newArray: [Catagorys] = self.tableArray.filter { $0.isHeading == true }
            for new in newArray {
                new.leftImageName = "plus"
            }
            self.tableArray = newArray
            self.tableViewWearList.reloadData()
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
