//
//  ApiServices.swift
//  MyOrder
//
//  Created by sourabh on 10/10/20.
//

import Alamofire

let CodeSuccess = 201


class ApiService: NSObject {
    static let shared = ApiService()
    func callServiceWith(apiName: String,
                         parameter: [String: Any]? = nil,
                         methods: HTTPMethod,
                         _ completion: @escaping ([String: Any]?, Error?) -> Void) {
        debugPrint("Request: ==> ", parameter ?? [:])
        if self.isConnectedToInternet() {
            var obj: DataRequest?
            let  url = kSERVERBASEURL + apiName
            debugPrint("URL: ==> ", url)
            obj =  AF.request(url, method: methods,  parameters: parameter, encoding: JSONEncoding.default)
            let backgroundQueue = DispatchQueue(label: "NetworkCall", qos: .background)
            backgroundQueue.async {
                obj!.responseJSON { response in
                    DispatchQueue.main.async {
                       
                        switch response.result {
                        case .success(let value):
                            if let json = value as? [String: Any] {
                                debugPrint("Response: ==> ",json)
                                let code = json["statusCode"] as? Int ?? 0
                                if  code == CodeSuccess {
                                    completion(json, nil)
                                }else {
                                    let msg = json["message"] as? String ?? Someerror
                                    let errorTemp = NSError(domain: "", code: code,
                                                            userInfo: [NSLocalizedDescriptionKey: msg])
                                    completion(nil, errorTemp)
                                }
                            }
                        case .failure(let error):
                            completion(nil, error)
                        }
                    }
                }
            }
        } else {
            let errorTemp = NSError(domain: "", code: -1005,
                                    userInfo: [NSLocalizedDescriptionKey: NoInternet])
            completion(nil, errorTemp)
        }
    }
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    func uploadImageServiceCall(image: Data,
                                apiName: String,
                                fileName: String,
                                parameter: [String: Any],
                                _ completion: @escaping ([String: Any]?, Error?) -> Void) {
        debugPrint("Request: ==> ", parameter)
        if self.isConnectedToInternet() {
            let  url = kSERVERBASEURL + apiName
            debugPrint("URL: ==> ", url)
            AF.upload(multipartFormData: { multiPart in
                for (key, value) in parameter {
                    multiPart.append("image/jpeg".data(using: String.Encoding.utf8)!, withName: "Content-Type")
                    multiPart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                multiPart.append(image, withName: fileName, fileName: "profilePicture", mimeType: "image/jpeg")
            }, to: url )
            .uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            debugPrint("Response: ==> ",json)
                            let code = json["statusCode"] as? Int ?? 0
                            if  code == CodeSuccess {
                                completion(json, nil)
                            }else {
                                let msg = json["message"] as? String ?? Someerror
                                let errorTemp = NSError(domain: "", code: code,
                                                        userInfo: [NSLocalizedDescriptionKey: msg])
                                completion(nil, errorTemp)
                            }
                        }
                    case .failure(let error):
                        completion(nil, error)
                    }
                }
            })
        } else {
            let errorTemp = NSError(domain: "", code: -1005,
                                    userInfo: [NSLocalizedDescriptionKey: NoInternet])
            completion(nil, errorTemp)
        }
    }
}
