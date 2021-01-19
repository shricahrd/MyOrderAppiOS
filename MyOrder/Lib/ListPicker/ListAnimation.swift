//
//  ListAnimation.swift
//  GWLListPicker
//
//  Created by sourabh on 22/05/20.
//  Copyright © 2020 Galaxyweblinks. All rights reserved.
//

import UIKit
class ListAnimation {
    func showAnimation(inview: UIView, sheetView: UIView){
        sheetView.alpha = 0
        inview.alpha = 0
        inview.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            sheetView.alpha = 1
            inview.alpha = 1
            inview.layoutIfNeeded()
        }) { (value) in
            sheetView.alpha = 1
            inview.alpha = 1
            inview.layoutIfNeeded()
        }
    }
    func hideAnimation(inview: UIView, sheetView: UIView){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            sheetView.alpha = 0
            inview.alpha = 0
            inview.layoutIfNeeded()
        }) { (value) in
            sheetView.alpha = 0
            inview.alpha = 0
            inview.layoutIfNeeded()
            inview.removeFromSuperview()
        }
    }
}
