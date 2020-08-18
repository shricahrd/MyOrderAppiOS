//
//  BaseCommand.swift
//  Nexopt
//

import UIKit

class BaseCommand: NSObject {
    
    func validate(completion: @escaping (Bool, String?) -> Void) {
        
        completion(true, nil)
    }
}
