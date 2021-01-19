//
//  AddressListViewController.swift
//  MyOrder
//
//  Created by sourabh on 20/10/20.
//

import UIKit
class AddressList: UITableViewCell {
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var buttonShipping: UIButton!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    
    func setCellData(aAddressListModel: AddressListModel) {
        
        self.labelName.text = aAddressListModel.fld_user_name
        self.labelAddress.text = aAddressListModel.fld_user_address + ", " +
            aAddressListModel.fld_user_country + ", " +
            aAddressListModel.fld_user_state_name + ", " +
            aAddressListModel.fld_user_city_name + ", " +
            aAddressListModel.fld_user_area_name + ", " +
            aAddressListModel.fld_user_pincode
        
        buttonShipping.setImage(#imageLiteral(resourceName: "uncheckList"), for: .normal)
        if aAddressListModel.fld_address_default == true {
            buttonShipping.setImage(#imageLiteral(resourceName: "checkList"), for: .normal)
        }
        
    }
}
class AddressListViewController: BaseViewController {
    @IBOutlet weak var tableVIewAddress: UITableView!
    var aAddressListViewModel = AddressListViewModel()
    var aAddressListModel : [AddressListModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAddressServiceCall()
        self.addRightBarButton()
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension AddressListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aAddressListModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressList") as! AddressList
        cell.setCellData(aAddressListModel: aAddressListModel[indexPath.row])
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            cell.viewShadow.shadowWithRadius()
        }
        cell.buttonShipping.tag = indexPath.row
        cell.buttonShipping.addTarget(self, action: #selector(self.actionOnShipp), for: UIControl.Event.touchUpInside)
        
        cell.buttonDelete.tag = indexPath.row
        cell.buttonDelete.addTarget(self, action: #selector(self.actionOnDelete), for: UIControl.Event.touchUpInside)
        
        cell.buttonEdit.tag = indexPath.row
        cell.buttonEdit.addTarget(self, action: #selector(self.actionOnEdit), for: UIControl.Event.touchUpInside)
        
        
        cell.selectionStyle = .none
        cell.contentView.layoutIfNeeded()
        return cell
    }
    @objc func actionOnShipp(sender: UIButton) {
        if aAddressListModel[sender.tag].fld_address_default == false {
            self.updateDefaultAddressServiceCall(aIndex: sender.tag)
        }
    }
    @objc func actionOnDelete(sender: UIButton) {
        self.deleteAddressServiceCall(aIndex: sender.tag)
    }
    @objc func actionOnEdit(sender: UIButton) {
        if let aAddAddressViewController = AddAddressViewController.getController(story: "Profile")  as? AddAddressViewController {
            aAddAddressViewController.aAddressListModel = self.aAddressListModel[sender.tag]
            self.navigationController?.pushViewController(aAddAddressViewController, animated: true)
        }
    }
}
extension AddressListViewController {
    func getAddressServiceCall() {
        self.showActivity()
        self.aAddressListViewModel.aGetAddressListServiceCall { (model) in
            self.hideActivity()
            self.aAddressListModel = model
            self.aAddressListModel.sort {
                $0.fld_address_id < $1.fld_address_id
            }
            self.tableVIewAddress.reloadData()
        }  aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    
    func updateDefaultAddressServiceCall(aIndex: Int) {
        self.showActivity()
        self.aAddressListViewModel.updateDefaultAddressServiceCall(aFld_address_id: aAddressListModel[aIndex].fld_address_id,
                                                        aFld_address_default: aAddressListModel[aIndex].fld_address_default ? 0 : 1)
        { (msg) in
            self.hideActivity()
            self.showAlartWith(message: msg) { (done) in
                for obj in self.aAddressListModel {
                    obj.fld_address_default = false
                }
                self.aAddressListModel.sort {
                    $0.fld_address_id < $1.fld_address_id
                }
                self.aAddressListModel[aIndex].fld_address_default = true
                self.tableVIewAddress.reloadData()
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    
    func deleteAddressServiceCall(aIndex: Int) {
        self.showActivity()
        self.aAddressListViewModel.delteAddressServiceCall(aFld_address_id: aAddressListModel[aIndex].fld_address_id)
        { (msg) in
            self.hideActivity()
            self.showAlartWith(message: msg) { (done) in
                self.aAddressListModel.sort {
                    $0.fld_address_id < $1.fld_address_id
                }
                self.aAddressListModel.remove(at: aIndex)
                self.tableVIewAddress.reloadData()
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}

