//
//  Constraints.swift
//  MyOrder
//
//  Created by gwl on 10/10/20.
//

typealias Failed = (_ error: Error?) -> Void

enum UserType : Int {
    case manufacture = 1
    case stockist = 2
    case distributor = 3
    case retailer = 4
    case agent = 5
    case unknown = 0
}

enum LeftPenalType : Int {
    case none = 0
    case category = 1
    case dashboard = 2
    case myOrders = 3
    case wishlist = 4
    case cart = 5
    case myProfile = 6
    case invoice = 7
    case ledger = 8
    case issues = 9
    case about = 10
    case helpSupport = 11
}

let OldUser                 = "OldUser"
let OldUserType             = "OldUserType"

let NoInternet              = "Internet connection not available."
let Someerror               = "Some error occour."
let OTPSend                 = "OTP is sent to your register phone number."

let SelectRole              = "Please select role."
let SelectUsername          = "Please enter username."
let SelectEmail             = "Please enter email."
let SelectVaildEmail        = "Please enter valid email."
let SelectPassword          = "Please enter password."
let SelectConfirmPassword   = "Please enter confirm password."
let SelectPasswordMatched   = "Password & confirm password not matched."
let SelectMobile            = "Please enter mobile."
let SelectDigitMobile       = "Please enter 10 digit mobile."

let SelectDate              = "Please select date."
let SelectPaymentMode       = "Please select payment mode."
let SelectAmount            = "Please enter amount."
let SelectTxNumber          = "Please enter Transaction number."
let SelectAttachment        = "Please select attachment."

let SelectTitle              = "Please select title."
let SelectDis                = "Please select discription."


let SelectCouponCode        = "Please enter coupon code."


let SelectFullName          = "Please enter fullname."
let SelectAddress           = "Please enter address."
let SelectCity              = "Please enter city."
let SelectState             = "Please enter state."
let SelectArea              = "Please enter area."
let SelectCountry           = "Please enter country."
let SelectZip               = "Please enter zipcode."

let SelectColor             = "Please select color."
let SelectSize              = "Minimum quantity for product size "

let SelectReason            = "Please select order cancel reason."



