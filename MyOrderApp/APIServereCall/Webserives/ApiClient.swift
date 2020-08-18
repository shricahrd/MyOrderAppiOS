//
//  ApiClient.swift
//  Trolleey
//
//  Created by Ivica Technologies on 28/05/20.
//  Copyright © 2020 Brainiuminfotech. All rights reserved.
//

import Foundation
import Alamofire


class ApiClient{
    @discardableResult
    private static func dataRequst<T:Decodable>(roughter:APIRouter,decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,AFError>)-> Void ) -> DataRequest {
        return AF.request(roughter).responseDecodable (decoder: decoder){ (response: DataResponse<T,AFError>) in
            completion(response.result)
        }
    }
    
    static func loder<T:Decodable>(roughter:APIRouter,completion:@escaping(T) -> Void){
        let jsondecoder = JSONDecoder()
        dataRequst(roughter: roughter, decoder: jsondecoder) { (result: Result<T,AFError>) in
            switch result {
            case.success(let t):
                completion(t)
                
            case.failure(let error):
                print("ERROR CODE:",error.localizedDescription)
                
            }
        }
    }
}

