//
//  AddAddressViewController.swift
//  MyOrder
//
//  Created by sourabh on 20/10/20.
//

import UIKit

class AddAddressViewController: BaseViewController {
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldArea: UITextField!
    @IBOutlet weak var textFieldState: UITextField!
    @IBOutlet weak var textFieldCountry: UITextField!
    @IBOutlet weak var textFieldZip: UITextField!
    @IBOutlet weak var buttonSave: BorderButton!
    @IBOutlet weak var activityState: UIActivityIndicatorView!
    @IBOutlet weak var activityCity: UIActivityIndicatorView!
    @IBOutlet weak var activityArea: UIActivityIndicatorView!

    var aAddAddressViewModel = AddAddressViewModel()
    var aAddressListModel: AddressListModel? = nil
    var aStateList: [StateList] = []
    var aCityList: [CityList] = []
    var aAreaList: [AreaList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.activityState.stopAnimating()
        self.activityCity.stopAnimating()
        self.activityArea.stopAnimating()
        #if targetEnvironment(simulator)
        self.textFieldFullName.text = "Jai kumar test"
        self.textFieldAddress.text = "301 Court Road,  Ashok nager,  Okhla III test"
        self.textFieldCity.text = "Noida"
        self.textFieldState.text = "Uttar Pradesh"
        self.textFieldCountry.text = "India"
        self.textFieldArea.text = "Noida Area test"
        self.textFieldZip.text = "201302"
        #endif
        if aAddressListModel != nil {
            self.textFieldFullName.text = aAddressListModel?.fld_user_name
            self.textFieldAddress.text = aAddressListModel?.fld_user_address
            self.textFieldCity.text = aAddressListModel?.fld_user_city
            self.textFieldState.text = aAddressListModel?.fld_user_state
            self.textFieldCountry.text = aAddressListModel?.fld_user_country
            self.textFieldZip.text = aAddressListModel?.fld_user_pincode
            self.buttonSave.setTitle("UPDATE", for: .normal)
        }
        self.getStates(shouldShowPopUp: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnState(_ sender: Any) {
        self.getStates()
    }
    @IBAction func actionOnSave(_ sender: Any) {
        if let text = self.isValidateUI() {
            self.showAlartWith(message: text)
        }else {
            self.view.resignFirstResponder()
            self.addAddressServiceCall()
        }
    }
    @IBAction func actionOnCity(_ sender: Any) {
        if self.textFieldState.text?.isEmpty == false {
            if let state = aStateList.first(where: {$0.name == self.textFieldState.text!}) {
                self.getCitys(cityId: state.id)
            }
        } else {
            self.showAlartWith(message: SelectState)
        }
    }
    @IBAction func actionOnArea(_ sender: Any) {
        if self.textFieldState.text?.isEmpty == false {
            if self.textFieldCity.text?.isEmpty == false {
                if let states = aStateList.first(where: {$0.name == self.textFieldState.text!}) {
                    if let city = aCityList.first(where: {$0.name == self.textFieldCity.text!}) {
                        self.getAreas(stateid: states.id, cityId: city.id)
                    }
                }
            } else {
                self.showAlartWith(message: SelectCity)
            }
        } else {
            self.showAlartWith(message: SelectState)
        }
    }
    
    func isValidateUI() -> String? {
        if self.textFieldFullName.text?.isEmpty == true {
            return SelectFullName
        }
        if self.textFieldAddress.text?.isEmpty == true {
            return SelectAddress
        }
        if self.textFieldCountry.text?.isEmpty == true {
            return SelectCountry
        }
        if self.textFieldState.text?.isEmpty == true {
            return SelectState
        }
        if self.textFieldCity.text?.isEmpty == true {
            return SelectCity
        }
        if self.textFieldArea.text?.isEmpty == true {
            return SelectArea
        }
        if self.textFieldZip.text?.isEmpty == true {
            return SelectZip
        }
        return nil
    }
    func showStates() {
        let stateName = aStateList.map { $0.name }
        GWLListPicker.shared.showSingleSelect(title: "Please select state", tableArray: stateName, selected: [self.textFieldState.text!] ,backgroundColor: .white, highLightColor: UIColor(named: "AppLightBlue")!){ (value) in
            self.textFieldState.text = value?.first
        }
    }
    func showCitys() {
        let cityName = aCityList.map { $0.name }
        GWLListPicker.shared.showSingleSelect(title: "Please select city", tableArray: cityName, selected: [self.textFieldCity.text!] ,backgroundColor: .white, highLightColor: UIColor(named: "AppLightBlue")!){ (value) in
            self.textFieldCity.text = value?.first
        }
    }
    func showAreas() {
        let areaName = aAreaList.map { $0.name }
        GWLListPicker.shared.showSingleSelect(title: "Please select area", tableArray: areaName, selected: [self.textFieldArea.text!] ,backgroundColor: .white, highLightColor: UIColor(named: "AppLightBlue")!){ (value) in
            self.textFieldArea.text = value?.first
        }
    }
}
extension AddAddressViewController {
    func addAddressServiceCall() {
        self.showActivity()
        if aAddressListModel != nil {
            var stateId = 0
            var cityId = 0
            var areaId = 0
            if let state = self.aStateList.first(where: {$0.name == self.textFieldState.text ?? ""}) {
                stateId = state.id
            }
            if let city = self.aCityList.first(where: {$0.name == self.textFieldCity.text ?? ""}) {
                cityId = city.id
            }
            if let area = self.aAreaList.first(where: {$0.name == self.textFieldArea.text ?? ""}) {
                areaId = area.id
            }
            self.aAddAddressViewModel.aUpdateAddressServiceCall(aFullName: self.textFieldFullName.text ?? "",
                                                                aAddress: self.textFieldAddress.text ?? "",
                                                                aCity: cityId.description,
                                                                aState: stateId.description,
                                                                aCountry: self.textFieldCountry.text ?? "",
                                                                aArea: areaId.description,
                                                                aZip: self.textFieldZip.text ?? "",
                                                                aAddressListModel: self.aAddressListModel!) { (msg) in
                self.hideActivity()
                self.showAlartWith(message: msg) { (done) in
                    self.navigationController?.popViewController(animated: true)
                }
            } aFailed: { (error) in
                self.hideActivity()
                self.showAlartWith(message: error!.localizedDescription)
            }
        }else {
            var stateId = 0
            var cityId = 0
            var areaId = 0
            if let state = self.aStateList.first(where: {$0.name == self.textFieldState.text ?? ""}) {
                stateId = state.id
            }
            if let city = self.aCityList.first(where: {$0.name == self.textFieldCity.text ?? ""}) {
                cityId = city.id
            }
            if let area = self.aAreaList.first(where: {$0.name == self.textFieldArea.text ?? ""}) {
                areaId = area.id
            }

            self.aAddAddressViewModel.aAddAddressServiceCall(aFullName: self.textFieldFullName.text ?? "",
                                                             aAddress: self.textFieldAddress.text ?? "",
                                                             aCity: cityId.description,
                                                             aState: stateId.description,
                                                             aCountry: self.textFieldCountry.text ?? "",
                                                             aZip: self.textFieldZip.text ?? "",
                                                             aArea: areaId.description) { (msg) in
                self.hideActivity()
                self.showAlartWith(message: msg) { (done) in
                    self.navigationController?.popViewController(animated: true)
                }
            }  aFailed: { (error) in
                self.hideActivity()
                self.showAlartWith(message: error!.localizedDescription)
            }
        }
    }
    func getStates(shouldShowPopUp: Bool = true){
        self.activityState.startAnimating()
        self.aAddAddressViewModel.getStates { (states) in
            self.activityState.stopAnimating()
            self.aStateList = states
            if shouldShowPopUp == true {
                self.showStates()
            }else {
                if let state = self.aStateList.first(where: {$0.name == self.textFieldState.text ?? ""}) {
                    self.getCitys(cityId: state.id, shouldShowPopUp: shouldShowPopUp)
                }
            }
        }  aFailed: { (error) in
            self.activityState.stopAnimating()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func getCitys(cityId: Int, shouldShowPopUp: Bool = true){
        self.activityCity.startAnimating()
        self.aAddAddressViewModel.getCitys(aStateID: cityId) { (city) in
            self.activityCity.stopAnimating()
            self.aCityList = city
            if shouldShowPopUp == true {
                self.showCitys()
            }else {
                if let states = self.aStateList.first(where: {$0.name == self.textFieldState.text ?? ""}) {
                    if let city = self.aCityList.first(where: {$0.name == self.textFieldCity.text ?? ""}) {
                        self.getAreas(stateid: states.id, cityId: city.id, shouldShowPopUp: shouldShowPopUp)
                    }
                }
            }
        }  aFailed: { (error) in
            self.activityCity.stopAnimating()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func getAreas(stateid: Int, cityId: Int, shouldShowPopUp: Bool = true){
        self.activityArea.startAnimating()
        self.aAddAddressViewModel.getAreas(aStateID: stateid, aCityID: cityId) { (area) in
            self.activityArea.stopAnimating()
            self.aAreaList = area
            if shouldShowPopUp == true {
                self.showAreas()
            }
        }  aFailed: { (error) in
            self.activityArea.stopAnimating()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
