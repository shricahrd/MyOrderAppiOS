// WebServices.swift
// Created by socmo on 10/12/15.
// Copyright © 2015 socmo. All Rights Reserved.
import Foundation
import AFNetworking
let baseUrl = ""
let Production_URL = "https://" + baseUrl
let Market_Place_URL = Production_URL + "v1/marketplace/"
let Pubnub_URL = Production_URL + "pn/"

enum AppReleaseConstants {
    static let currentAppVersion: Double = 6.3 //5.7 , 5.2 // 5.1 // 4.8
    static let hokoIOSToken = "2fafd45ded4e027956202ba743bc1cdaddf997b1"
    static let appViralityAppKey = "34fefb651eed4274b6f7a6de00c0aca2"
}
let pubnubPublishKey   = "pub-c-866de466-c389-4422-b050-cf4a01f62159"        // Dev/Stage
let pubnubSubscribeKey = "sub-c-909ed5f6-f279-11e6-af46-02ee2ddab7fe"
//let pubnubPublishKey = "pub-c-465bf8a5-f658-41c8-b1bb-f3ee0b307ef6"        // Live
//let pubnubSubscribeKey = "sub-c-aa35a376-57de-11e7-af75-02ee2ddab7fe"
let isMtractionEnabled = true
// MARK: - API's
enum WebService {
    static let loginNew = "login_new"
    static let splash = "splash"
    static let myAppointment = "myappointment"


}

enum JsonParams {
    static let deviceType = "3"
}



//MARK:- SET HTTP HEADER
func setHttpHeader(manager: AFHTTPSessionManager) {
    
    let ParamDeviceType = "Param-DeviceType"
    let ParamNonce = "Param-Nonce"
    let ParamAuthorization = "Param-Authorization"
    let ContentType = "Content-Type"
    let DIToken = "DIToken"
    let AcceptLanguage = "Accept-Language"
    let ParamVcode = "Param-Vcode"
    let DINonce = "DINonce"
    let DIDeviceType = "DIDeviceType"
    let Applicationjson = "application/json"
    
    manager.requestSerializer = AFJSONRequestSerializer()
    //manager.requestSerializer.timeoutInterval = 0.5
    AFNetworkReachabilityManager.shared().startMonitoring()
    manager.requestSerializer.setValue(Applicationjson, forHTTPHeaderField: ContentType)
    manager.requestSerializer.setValue("\(DIDeviceType) \(JsonParams.deviceType)" , forHTTPHeaderField: ParamDeviceType)
    print(ParamDeviceType, manager.requestSerializer.value(forHTTPHeaderField: ParamDeviceType) ?? "")
    manager.requestSerializer.setValue("", forHTTPHeaderField: ParamNonce)
    manager.requestSerializer.setValue("", forHTTPHeaderField: ParamAuthorization)
    manager.requestSerializer.setValue("", forHTTPHeaderField: AcceptLanguage)
    manager.requestSerializer.setValue("\(AppReleaseConstants.currentAppVersion)", forHTTPHeaderField: ParamVcode)
    print(ContentType, manager.requestSerializer.value(forHTTPHeaderField: ContentType) ?? "")
    print(DIDeviceType, manager.requestSerializer.value(forHTTPHeaderField: ParamDeviceType) ?? "")
    print(ParamNonce, manager.requestSerializer.value(forHTTPHeaderField: ParamNonce) ?? "")
    print(ParamAuthorization, manager.requestSerializer.value(forHTTPHeaderField: ParamAuthorization) ?? "");
    print(AcceptLanguage, manager.requestSerializer.value(forHTTPHeaderField: AcceptLanguage) ?? "");
    print(ParamVcode, manager.requestSerializer.value(forHTTPHeaderField: ParamVcode) ?? "");
}

// MARK: - API Functions
func getAPIAction(_ apiName: String, showGenricErrorPopup: Bool, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let appendUrlInBase = "resttherapy/"
    let baseURLWithFileName = "\(Production_URL)" + "\(appendUrlInBase)" + "\(apiName)" + "/"
    print("Post API: ", baseURLWithFileName)
    let manager = AFHTTPSessionManager()
    setHttpHeader(manager: manager)
    if AFNetworkReachabilityManager.shared().isReachable == false && showGenricErrorPopup == true {
        let responseDict = [
            "api_error": "Please check your network connection",
            "error_detail":"Please check your network connection"
        ]
        onCompletion(responseDict as NSDictionary?)
        return
    }
    var responseDict = NSDictionary()
    manager.post(baseURLWithFileName,
                 parameters: nil,
                 progress: nil,
                 success: {(task: URLSessionTask, responseObject: Any?) -> Void in
                    if let response = responseObject as? NSDictionary {
                        responseDict = response
                    } else {
                        print("Post api response nil")
                    }
                    if let status = responseDict["status"] as? Int, status == 0, let message = responseDict["message"] as? String {
                        if let responseCode = responseDict["responseCode"] as? Int, responseCode == 412 {
                            CommonMethods.sharedInstance.showCustomAlertViewWith(title: "Sorry", message: message, buttonTitle: "Ok")
                        } else {
                            if showGenricErrorPopup == true {
                                 CommonAlert.shared.showActionAlertView(title: "Sorry", message: message, actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                            }
                        }
                    }
                    onCompletion(responseDict)
    },
                 failure: {(operation: URLSessionTask?, error: Error) -> Void in
                    print("API Error \(apiName) : \(error)")
                    responseDict = ["api_error": "\(error.localizedDescription)",
                        "error_detail":error.localizedDescription]
                    onCompletion(responseDict)
                    let nsError = error as NSError
                    
                    if nsError.code == -1011 {
                          CommonAlert.shared.showActionAlertView(title: "Sorry", message: "Something went wrong. Please try again", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    } else if nsError.code == -1009 || nsError.code == -1009 {
                       
                    } else if nsError.code == 54 {
                        CommonAlert.shared.showActionAlertView(title: "Sorry", message: "Something went wrong. Please try again", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    }
    })
}

//MARK: - API Functions
func postMarketPlaceAPIAction(_ apiName: String, parameters: [String: Any], showGenricErrorPopup: Bool, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let baseURLWithFileName = "\(Market_Place_URL)" + "\(apiName)" + "/"
    print("Post API: ", baseURLWithFileName)
    let manager = AFHTTPSessionManager()
    setHttpHeader(manager: manager)
    if AFNetworkReachabilityManager.shared().isReachable == false && showGenricErrorPopup == true {
        let responseDict = [
            "api_error": "Please check your network connection",
            "error_detail":"Please check your network connection"
        ]
        onCompletion(responseDict as NSDictionary?)
        return
    }
    var responseDict = NSDictionary()
    manager.post(baseURLWithFileName,
                 parameters: parameters,
                 progress: nil,
                 success: { (task: URLSessionTask, responseObject: Any?) -> Void in
                    if let response = responseObject as? NSDictionary {
                        responseDict = response
                    } else {
                        print("Post api response nil")
                    }
                    if let status = responseDict["status"] as? Int, status == 0, let message = responseDict["message"] as? String {
                        if let responseCode = responseDict["responseCode"] as? Int, responseCode == 412 {
                            CommonMethods.sharedInstance.showCustomAlertViewWith(title: "", message: message, buttonTitle: "Ok")
                        } else {
                            if showGenricErrorPopup == true {
                                 CommonAlert.shared.showActionAlertView(title: "Sorry", message: message, actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                            }
                        }
                    }
                    onCompletion(responseDict)
    },
                 failure: { (operation: URLSessionTask?, error: Error) -> Void in
                    print("API Error \(apiName) : \(error)")
                    responseDict = ["api_error": "\(error.localizedDescription)",
                        "error_detail":error.localizedDescription]
                    onCompletion(responseDict)
                    let nsError = error as NSError
                    if nsError.code == -1011 {
                       CommonAlert.shared.showActionAlertView(title: "Sorry", message: "Something went wrong. Please try again", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    } else if nsError.code == -1009 || nsError.code == -1009 {
                       
                    } else if nsError.code == -1001 {
                       CommonAlert.shared.showActionAlertView(title: "Sorry", message: "Something went wrong. Please try again", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    } else if nsError.code == 54 {
                         CommonAlert.shared.showActionAlertView(title: "Sorry", message: "Something went wrong. Please try again", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    }
    })
}

func postAPIActionVersonOne(_ apiName: String, parameters: [String: Any], showGenricErrorPopup: Bool, doCallWithResttherapy:Bool = true, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let restthereapy = "v1/"
    postAPIAction(appendUrlInBase:restthereapy , apiName, parameters: parameters, showGenricErrorPopup: showGenricErrorPopup, onCompletion: onCompletion)
}

func postAPIAction(_ apiName: String, parameters: [String: Any], showGenricErrorPopup: Bool, doCallWithResttherapy:Bool = true, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let restthereapy = doCallWithResttherapy ? "resttherapy/" : ""
    postAPIAction(appendUrlInBase:restthereapy , apiName, parameters: parameters, showGenricErrorPopup: showGenricErrorPopup, onCompletion: onCompletion)
}

func postDoctorListingAPIAction(_ apiName: String, parameters: [String: Any], showGenricErrorPopup: Bool, doCallWithResttherapy:Bool = true, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let restthereapy = doCallWithResttherapy ? "v1/" : ""
    postAPIAction(appendUrlInBase:restthereapy , apiName, parameters: parameters, showGenricErrorPopup: showGenricErrorPopup, onCompletion: onCompletion)
}
func postAPIWhatsNew(_ apiName: String, parameters: [String: Any], showGenricErrorPopup: Bool, doCallWithResttherapy:Bool = true, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let restthereapy = doCallWithResttherapy ? "v1/help/" : ""
    postAPIAction(appendUrlInBase: restthereapy , apiName, parameters: parameters, showGenricErrorPopup: showGenricErrorPopup, onCompletion: onCompletion)
}

// MARK: - API Functions
func postAPIAction(appendUrlInBase: String, _ apiName: String, parameters: [String: Any], showGenricErrorPopup: Bool, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let baseURLWithFileName = "\(Production_URL)" + "\(appendUrlInBase)" + "\(apiName)" + "/"
    print("Post API: ", baseURLWithFileName)
    let manager = AFHTTPSessionManager()
    setHttpHeader(manager: manager)
    if AFNetworkReachabilityManager.shared().isReachable == false && showGenricErrorPopup == true {
        let responseDict = [
            "api_error": "Please check your network connection" ,
            "error_detail":"Please check your network connection"
        ]
        onCompletion(responseDict as NSDictionary?)
        return
    }
    var responseDict = NSDictionary()
    manager.post(baseURLWithFileName,
                 parameters: parameters,
                 progress: nil,
                 success: { (task: URLSessionTask, responseObject: Any?) -> Void in
                    if let response = responseObject as? NSDictionary {
                        responseDict = response
                    } else {
                        print("Post api response nil")
                    }
                    
                    if let status = responseDict["status"] as? Int, status == 0, let message = responseDict["message"] as? String {
                        if let responseCode = responseDict["responseCode"] as? Int, responseCode == 412 {
                            CommonMethods.sharedInstance.showCustomAlertViewWith(title: "Sorry" , message: message, buttonTitle: "Ok")
                        } else {
                            if showGenricErrorPopup == true {
                                CommonAlert.shared.showActionAlertView(title: "Sorry" , message: message, actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                            }
                        }
                    }
                    onCompletion(responseDict)
    },
                 failure: { (operation: URLSessionTask?, error: Error) -> Void in
                    print("API Error \(apiName) : \(error)")
                    responseDict = ["api_error": "\(error.localizedDescription)",
                        "error_detail":error.localizedDescription]
                    onCompletion(responseDict)
                    let nsError = error as NSError
                    if nsError.code == -1001 {
                    } else if nsError.code == -1009 || nsError.code == -1009 {
                        CommonAlert.shared.showActionAlertView(title: "Sorry", message: "Something went wrong. UnAuthorized Request" , actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    } else if nsError.code == 54 {
                        CommonAlert.shared.showActionAlertView(title: "Sorry", message: "Something went wrong. Please try again", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    } else if nsError.code == 403 {
                        CommonAlert.shared.showActionAlertView(title: "Sorry", message: "Something went wrong. UnAuthorized Request", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    }
    })
}

// MARK: - API Functions
func postPubNubAPIAction(_ apiName: String, parameters: [String: Any], showGenricErrorPopup: Bool, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let baseURLWithFileName = "\(Pubnub_URL)" + "\(apiName)" + "/"
    print("Post API: ", baseURLWithFileName)
    let manager = AFHTTPSessionManager()
    setHttpHeader(manager: manager)
    if AFNetworkReachabilityManager.shared().isReachable == false && showGenricErrorPopup == true {
        let responseDict = [
            "api_error": "Please check your network connection",
            "error_detail":"Please check your network connection"
        ]
        onCompletion(responseDict as NSDictionary?)
        return
    }
    var responseDict = NSDictionary()
    manager.post(baseURLWithFileName,
                 parameters: parameters,
                 progress: nil,
                 success: { (task: URLSessionTask, responseObject: Any?) -> Void in
                    if let response = responseObject as? NSDictionary {
                        responseDict = response
                    } else {
                        print("Post api response nil")
                    }
                    if let status = responseDict["status"] as? Int, status == 0, let message = responseDict["message"] as? String {
                        if let responseCode = responseDict["responseCode"] as? Int, responseCode == 412 {
                            CommonMethods.sharedInstance.showCustomAlertViewWith(title: "", message: message, buttonTitle: "Ok")
                        } else {
                            if showGenricErrorPopup == true {
                                CommonAlert.shared.showActionAlertView(title: "", message: message, actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                            }
                        }
                    }
                    onCompletion(responseDict)
    },
                 failure: { (operation: URLSessionTask?, error: Error) -> Void in
                    print("API Error \(apiName) : \(error)")
                    responseDict = ["api_error": "\(error.localizedDescription)",
                        "error_detail":error.localizedDescription]
                    onCompletion(responseDict)
                    let nsError = error as NSError
                    if nsError.code == -1011 {
                        CommonAlert.shared.showActionAlertView(title: "", message: "Something went wrong. Please try again", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    } else if nsError.code == -1009 || nsError.code == -1009 {

                    } else if nsError.code == 54 {
                        CommonAlert.shared.showActionAlertView(title: "", message: "Something went wrong. Please try again", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    }
    })
}

func getAPIAction(_ apiName: String, parameters: [String: Any]?, showGenricErrorPopup: Bool, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let appendUrlInBase = "resttherapy/"
    let baseURLWithFileName = "\(Production_URL)" + "\(appendUrlInBase)" + "\(apiName)" + "/"
    print("GET API:", baseURLWithFileName)
    let manager = AFHTTPSessionManager()
    setHttpHeader(manager: manager)
    if AFNetworkReachabilityManager.shared().isReachable == false && showGenricErrorPopup == true {
        let responseDict = [
            "api_error": "Please check your network connection",
            "error_detail":"Please check your network connection"
        ]
        onCompletion(responseDict as NSDictionary?)
        return
    }
    var responseDict = NSDictionary()
    manager.get(baseURLWithFileName,
                 parameters: parameters,
                 progress: nil,
                 success: { (task: URLSessionTask, responseObject: Any?) -> Void in
                    if let response = responseObject as? NSDictionary {
                        responseDict = response
                    } else {
                        print("Get api response nil")
                    }
                    if let status = responseDict["status"] as? Int, status == 0, let message = responseDict["message"] as? String {
                        if let responseCode = responseDict["responseCode"] as? Int, responseCode == 412 {
                            CommonMethods.sharedInstance.showCustomAlertViewWith(title: "", message: message, buttonTitle: "Ok")
                        } else {
                            if showGenricErrorPopup == true {
                                CommonAlert.shared.showActionAlertView(title: "", message: message, actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                            }
                        }
                    }
                    onCompletion(responseDict)
    },
                 failure: { (operation: URLSessionTask?, error: Error) -> Void in
                    print("API Error \(apiName) : \(error)")
                    responseDict = ["api_error": "\(error.localizedDescription)",
                        "error_detail":error.localizedDescription]
                    onCompletion(responseDict)
                    let nsError = error as NSError
                    if nsError.code == -1011 {
                        CommonAlert.shared.showActionAlertView(title: "", message: "Something went wrong. Please try again", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    } else if nsError.code == -1009 || nsError.code == -1009 {
                    } else if nsError.code == 54 {
                        CommonAlert.shared.showActionAlertView(title: "", message: "Something went wrong. Please try again", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
                    }
    })
}

