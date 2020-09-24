// WebServices.swift
// Created by socmo on 10/12/15.
// Copyright © 2015 socmo. All Rights Reserved.
import Foundation
import AFNetworking
let baseUrl = "https://aptechbangalore.com/myorder/api/"

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
    static let productdetail = "productdetail"
    static let productsearch = "productsearch"
    static let filtersnew = "filtersnew"
    static let filterProduct = "filterProduct"
    static let cart_add_update = "cart_add_update"
    static let cart = "cart"
    static let userAddresss = "userAddresss"
    static let updateAddress = "updateAddress"
    static let city_listing = "city_listing"
    static let area_listing = "area_listing"
    static let state_listing = "state_listing"
    static let applyCoupon = "applyCoupon"
    static let cart_review = "cart_review"
    static let saveOrder = "saveOrder"
    static let get_dependend_size = "get_dependend_size"
    static let distributor_login = "distributor_login"
    static let homeProducts = "homeProducts"
    static let addAddress = "addAddress"
    static let deleteAddress = "deleteAddress"
    static let addDefaultAddress = "addDefaultAddress"
}

enum JsonParams {
    static let deviceType = "3"
}



//MARK:- SET HTTP HEADER
func setHttpHeader(manager: AFHTTPSessionManager) {
//    let ParamDeviceType = "Param-DeviceType"
//    let ParamNonce = "Param-Nonce"
//    let ParamAuthorization = "Param-Authorization"
    let ContentType = "Content-Type"
//    let DIToken = "DIToken"
//    let AcceptLanguage = "Accept-Language"
//    let ParamVcode = "Param-Vcode"
//    let DINonce = "DINonce"
//    let DIDeviceType = "DIDeviceType"
    let Applicationjson = "application/json"
//  urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    manager.requestSerializer = AFJSONRequestSerializer()
    manager.requestSerializer.timeoutInterval = 60
    AFNetworkReachabilityManager.shared().startMonitoring()
    //manager.requestSerializer.setValue(Applicationjson, forHTTPHeaderField: ContentType)
    manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Current-Type")
    print(ContentType, manager.requestSerializer.value(forHTTPHeaderField: ContentType) ?? "")
    
  
//    manager.requestSerializer.setValue("\(DIDeviceType) \(JsonParams.deviceType)" , forHTTPHeaderField: ParamDeviceType)
//    print(ParamDeviceType, manager.requestSerializer.value(forHTTPHeaderField: ParamDeviceType) ?? "")
//    manager.requestSerializer.setValue("", forHTTPHeaderField: ParamNonce)
//    manager.requestSerializer.setValue("", forHTTPHeaderField: ParamAuthorization)
//    manager.requestSerializer.setValue("", forHTTPHeaderField: AcceptLanguage)
//    manager.requestSerializer.setValue("\(AppReleaseConstants.currentAppVersion)", forHTTPHeaderField: ParamVcode)
    
//    print(DIDeviceType, manager.requestSerializer.value(forHTTPHeaderField: ParamDeviceType) ?? "")
//    print(ParamNonce, manager.requestSerializer.value(forHTTPHeaderField: ParamNonce) ?? "")
//    print(ParamAuthorization, manager.requestSerializer.value(forHTTPHeaderField: ParamAuthorization) ?? "");
//    print(AcceptLanguage, manager.requestSerializer.value(forHTTPHeaderField: AcceptLanguage) ?? "");
//    print(ParamVcode, manager.requestSerializer.value(forHTTPHeaderField: ParamVcode) ?? "");
}

// MARK: - API Functions
func getAPIAction(_ apiName: String, showGenricErrorPopup: Bool, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let appendUrlInBase = "resttherapy/"
    let baseURLWithFileName = "\(baseUrl)" + "\(appendUrlInBase)" + "\(apiName)" + "/"
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

// MARK: - API Functions
func postAPIAction(_ apiName: String, parameters: [String: Any], showGenricErrorPopup: Bool, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let baseURLWithFileName = "\(baseUrl)" + "\(apiName)"
    print("Post API: ", baseURLWithFileName)
     let manager = AFHTTPSessionManager()
     manager.requestSerializer = AFJSONRequestSerializer()
    
     manager.requestSerializer.timeoutInterval = 60
     AFNetworkReachabilityManager.shared().startMonitoring()
//     manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "ContentType")
////    setHttpHeader(manager: manager)
  

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

func getAPIAction(_ apiName: String, parameters: [String: Any]?, showGenricErrorPopup: Bool, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let baseURLWithFileName = "\(baseUrl)" + "\(apiName)"
    print("Post API: ", baseURLWithFileName)
    
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    let urlString = NSString(format: baseURLWithFileName as NSString)
    print("get wallet balance url string is \(urlString)")
       //let url = NSURL(string: urlString as String)
    let request : NSMutableURLRequest = NSMutableURLRequest()
    request.url = NSURL(string: NSString(format: "%@", urlString) as String) as URL?
    request.httpMethod = "GET"
    request.timeoutInterval = 30
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
    //create dataTask using the session object to send data to the server
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
       var responseDict = NSDictionary()
       guard error == nil else {
            onCompletion(nil)
            return
        }
        guard let data = data else {
            return
        }
        do {
            //create json object from data
            if let responseObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
               print(responseObject)
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
            }
        } catch let error {
            print(error.localizedDescription)
            onCompletion(nil)
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
        }
    })
       dataTask.resume()
}

//MARK: - API Functions
func postMyOrderAPIAction(_ apiName: String, parameters: [String: Any], showGenricErrorPopup: Bool, onCompletion:@escaping (NSDictionary?) -> Void)  -> Void {
    let baseURLWithFileName = "\(baseUrl)" + "\(apiName)"
    print("Post API: ", baseURLWithFileName)
//    let manager = AFHTTPSessionManager()
//    manager.requestSerializer = AFJSONRequestSerializer()
//    manager.requestSerializer.timeoutInterval = 60
//    AFNetworkReachabilityManager.shared().startMonitoring()
//  manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
//  let parameters = [ "fld_brand_id": "",
//            "fld_cat_id": 2,
//            "fld_search_txt":""] as [String : Any]
    
     //create the url with URL
     let url = URL(string: baseURLWithFileName)! //change the url
     //create the session object
     let session = URLSession.shared
     //now create the URLRequest object using the url object
     var request = URLRequest(url: url)
     request.httpMethod = "POST" //set http method as POST
     do {
         request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
     } catch let error {
         print(error.localizedDescription)
     }
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     request.addValue("application/json", forHTTPHeaderField: "Accept")
     //create dataTask using the session object to send data to the server
       
    if AFNetworkReachabilityManager.shared().isReachable == false && showGenricErrorPopup == true {
            let responseDict = [
                "api_error": "Please check your network connection",
                "error_detail":"Please check your network connection"
            ]
            onCompletion(responseDict as NSDictionary?)
            return
    }
     let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        var responseDict = NSDictionary()
        guard error == nil else {
             onCompletion(nil)
             return
         }
         guard let data = data else {
             return
         }
         do {
             //create json object from data
             if let responseObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                print(responseObject)
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
             }
         } catch let error {
             print(error.localizedDescription)
             onCompletion(nil)
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
         }
     })
     task.resume()


}
extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}
