//
//  PropertySingleton.swift
//  BizzGear
//
//  Created by Sridivya on 24/02/19.
//  Copyright © 2019 Ivica Technologies. All rights reserved.
//

import Foundation
import UIKit

struct Singleton {
    class Properties {
        static let shared = Properties()
        private init(){}
       // var user: ??
        
    }
}



class DashedBorderView: UIView {
    
    let _border = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    func setup() {
        _border.strokeColor = UIColor.black.cgColor
        _border.fillColor = nil
        _border.lineDashPattern = [4, 4]
        self.layer.addSublayer(_border)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius:10).cgPath
        _border.frame = self.bounds
    }
}




