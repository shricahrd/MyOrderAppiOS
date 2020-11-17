//
//  ProfileViewController.swift
//  MyOrder
//
//  Created by gwl on 20/10/20.
//

import UIKit
/////////////////////
class ProfileViewController: BaseViewController {
    @IBOutlet weak var labelProfileName: UILabel!
    @IBOutlet weak var labelProfileNameTop: UILabel!
    @IBOutlet weak var labelProfileEmail: UILabel!
    @IBOutlet weak var labelProfileNumber: UILabel!
//    @IBOutlet weak var labelAddressName: UILabel!
    @IBOutlet weak var labelAddressAddress: UILabel!
    @IBOutlet weak var labelCompanyName: UILabel!
    @IBOutlet weak var labelCompanyAddressName: UILabel!
    @IBOutlet weak var labelCompanyAddress: UILabel!
    @IBOutlet weak var labelDocuments: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelProfileCompanyName: UILabel!
    
    var aProfileViewModel = ProfileViewModel()
    var aProfileModel = ProfileModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUi()
        self.userProfileServiceCall()
        self.addRightBarButton()
    }
    @IBAction func actionOnEditProfile(_ sender: Any) {
        if let aEditProfileViewController = EditProfileViewController.getController(story: "Profile")  as? EditProfileViewController {
            aEditProfileViewController.aPersonalInfo = self.aProfileModel.aPersonalInfo
            aEditProfileViewController.aCompanyInfo = self.aProfileModel.aCompanyInfo
            self.navigationController?.pushViewController(aEditProfileViewController, animated: true)
        }
    }
    @IBAction func actionOnEditCompany(_ sender: Any) {
    }
    @IBAction func actionOnEditDocuments(_ sender: Any) {
    }
    @IBAction func actionOnChangePassword(_ sender: Any) {
        if let aChangePasswordViewController = ChangePasswordViewController.getController(story: "Main")  as? ChangePasswordViewController {
            aChangePasswordViewController.shouldShowBack = false
            self.navigationController?.pushViewController(aChangePasswordViewController, animated: true)
        }
    }
    @IBAction func actionOnLogout(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "WellcomeViewController") as! WellcomeViewController
        let centerNavVC = UINavigationController(rootViewController: redViewController)
        UIApplication.shared.windows.first?.rootViewController = centerNavVC
    }
}
extension ProfileViewController {
    func userProfileServiceCall() {
        self.showActivity()
        self.aProfileViewModel.userProfileServiceCall { (modle) in
            self.hideActivity()
            self.aProfileModel = modle
            self.updateUi()
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func updateUi() {
        self.labelProfileName.text = self.aProfileModel.aPersonalInfo.fld_user_name
        self.labelProfileNumber.text = self.aProfileModel.aPersonalInfo.fld_user_mobile
//        self.labelAddressName.text = self.aProfileModel.aShippingInfo.fld_shipping_name
        self.labelProfileNameTop.text = self.aProfileModel.aPersonalInfo.fld_user_name
        self.labelProfileEmail.text = self.aProfileModel.aPersonalInfo.fld_user_email
        self.labelProfileCompanyName.text = self.aProfileModel.aCompanyInfo.fld_company_name
//        aAddressListModel.fld_user_address + ", " +
//            aAddressListModel.fld_user_country + ", " +
//            aAddressListModel.fld_user_state + ", " +
//            aAddressListModel.fld_user_city + ", " +
//            aAddressListModel.fld_user_locality + ", " +
//            aAddressListModel.fld_user_pincode
        
        
        
        self.labelAddressAddress.text =  self.aProfileModel.aCompanyInfo.address + ", " +
            self.aProfileModel.aCompanyInfo.state_name + ", " +
            self.aProfileModel.aCompanyInfo.city_name + ", " +
            self.aProfileModel.aCompanyInfo.area_name + ", " +
            self.aProfileModel.aCompanyInfo.pincode
        
//        self.labelAddressAddress.text = self.aProfileModel.aShippingInfo.address + ", " +
//            self.aProfileModel.aShippingInfo.city + ", " +
//            self.aProfileModel.aShippingInfo.state + ", " +
//            self.aProfileModel.aShippingInfo.area + ", " +
//            self.aProfileModel.aShippingInfo.pincode
//
        
//        self.labelCompanyName.text = self.aProfileModel.aCompanyInfo.fld_company_name
//        self.labelCompanyAddressName.text = "--"
//        self.labelCompanyAddress.text = self.aProfileModel.aCompanyInfo.address + ", " +
//            self.aProfileModel.aCompanyInfo.city + ", " +
//            self.aProfileModel.aCompanyInfo.state + ", " +
//            self.aProfileModel.aCompanyInfo.area + ", " +
//            self.aProfileModel.aCompanyInfo.pincode
        
        let url = URL(string: self.aProfileModel.aPersonalInfo.profile_pic)
        self.imageViewProfile.kf.indicatorType = .activity
        self.imageViewProfile.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
    }
}
