//
//  BrandlistViewController.swift
//  MyOrder
//
//  Created by gwl on 12/10/20.
//

import UIKit

class BrandlistCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewCheck: UIImageView!
}

class BrandlistViewController: BaseViewController {
    @IBOutlet weak var tableViewBrand: UITableView!
    var aBrandlistViewModel = BrandlistViewModel()
    var mainArray: [Branddata] = []
    var tableArray: [Branddata] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.mainArray = tableArray
       // self.tableArray = aBrandlistViewModel.getBrandList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
    override func actionOnLeftIcon(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnClearAll(_ sender: Any) {
        for obj in tableArray {
            obj.isSelected = false
        }
        self.tableViewBrand.reloadData()
    }
    @IBAction func actionOnApply(_ sender: Any) {
        for controller in self.navigationController!.viewControllers {
            if let vc = controller as? FilterViewController {
                vc.aFilterModel?.aBranddata = self.mainArray
                break
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension BrandlistViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            self.tableArray = mainArray
            if updatedText.count > 0 {
                self.tableArray = self.tableArray.filter {$0.fld_name.lowercased().contains(updatedText.lowercased())}
            }
            
        }else {
            self.tableArray = mainArray
        }
        self.tableViewBrand.reloadData()
        return true
    }
}

extension BrandlistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.clear
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandlistCell") as! BrandlistCell
        let obj = tableArray[indexPath.row]
        cell.labelTitle.text = obj.fld_name
        cell.selectionStyle = .none
        if obj.isSelected == true {
            cell.labelTitle.textColor = UIColor(named: "AppLightBlue")
            cell.imageViewCheck.image = #imageLiteral(resourceName: "checkList")
        }else {
            cell.labelTitle.textColor = UIColor(named: "AppBlack")
            cell.imageViewCheck.image = #imageLiteral(resourceName: "uncheckList")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = tableArray[indexPath.row]
        obj.isSelected = !obj.isSelected
        self.tableViewBrand.reloadData()
    }
    
}
