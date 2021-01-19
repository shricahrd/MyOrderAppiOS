//
//  EditProfileViewController.swift
//  MyOrder
//
//  Created by sourabh on 20/10/20.
//

import UIKit

class EditProfileViewController: BaseViewController {
   
    @IBOutlet weak var tesxtFieldUsername: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldMobile: UITextField!
    @IBOutlet weak var imageViewProfile: UIImageView!
    
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldState: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldArea: UITextField!
    @IBOutlet weak var textFieldZip: UITextField!
   
    @IBOutlet weak var activityState: UIActivityIndicatorView!
    @IBOutlet weak var activityCity: UIActivityIndicatorView!
    @IBOutlet weak var activityArea: UIActivityIndicatorView!
    
    var aPersonalInfo = PersonalInfo()
    var aCompanyInfo = CompanyInfo()

    var aEditProfileViewModel = EditProfileViewModel()
    var aAddAddressViewModel = AddAddressViewModel()

    var imagePicker: ImagePicker!
    var shouldUploadImage = false
    
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
        self.tesxtFieldUsername.text = aPersonalInfo.fld_user_name
        self.textFieldEmail.text = aPersonalInfo.fld_user_email
        self.textFieldMobile.text = aPersonalInfo.fld_user_mobile
        let url = URL(string: aPersonalInfo.profile_pic)
        self.imageViewProfile.kf.indicatorType = .activity
        self.imageViewProfile.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.textFieldAddress.text = self.aCompanyInfo.address
        self.textFieldState.text = self.aCompanyInfo.state_name
        self.textFieldCity.text = self.aCompanyInfo.city_name
        self.textFieldArea.text = self.aCompanyInfo.area_name
        self.textFieldZip.text = self.aCompanyInfo.pincode
        self.getStates(shouldShowPopUp: false)
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
    @IBAction func actionOnSave(_ sender: Any) {
        if let text = self.isValidateUI() {
            self.showAlartWith(message: text)
        }else {
            self.view.resignFirstResponder()
            self.updatePersonalInto()
        }
    }
    @IBAction func actionOnEditImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    func isValidateUI() -> String? {
        if self.tesxtFieldUsername.text?.isEmpty == true {
            return SelectUsername
        }
        if self.textFieldEmail.text?.isEmpty == true {
            return SelectEmail
        }
        if self.isValidEmail(self.textFieldEmail.text!) == false {
            return SelectVaildEmail
        }
        if self.textFieldMobile.text?.isEmpty == true {
            return SelectMobile
        }
        if self.textFieldMobile.text!.count < 10 || self.textFieldMobile.text!.count > 10 {
            return SelectDigitMobile
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
    @IBAction func actionOnState(_ sender: Any) {
        self.getStates()
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
extension EditProfileViewController {
    func updatePersonalInto() {
        self.showActivity()
        
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
        
        self.aEditProfileViewModel.updatePersonalInfoServiceCall(aimage: self.shouldUploadImage ? self.imageViewProfile.image : nil,
                                                                 aFullName: self.tesxtFieldUsername.text ?? "",
                                                                 aEmail: self.textFieldEmail.text ?? "",
                                                                 aMobile: self.textFieldMobile.text ?? "",
                                                                 aAddress: self.textFieldAddress.text ?? "",
                                                                 aState: stateId.description,
                                                                 aCity: cityId.description,
                                                                 aArea: areaId.description,
                                                                 aPincode: self.textFieldZip.text ?? "") { (msg) in
            self.hideActivity()
            self.showAlartWith(message: msg) { (done) in
                self.navigationController?.popViewController(animated: true)
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
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
extension EditProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.shouldUploadImage = true
        self.imageViewProfile.image = image
    }
}
