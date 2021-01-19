//
//  BrandlistViewModel.swift
//  MyOrder
//
//  Created by sourabh on 12/10/20.
//

import UIKit

class BrandlistViewModel: NSObject {
    
    func getBrandList() -> [BrandlistModel] {
        var aArray: [BrandlistModel] = []
        aArray.append(BrandlistModel(title: "adidas"))
        aArray.append(BrandlistModel(title: "adidas Originals"))
        aArray.append(BrandlistModel(title: "Blend"))
        aArray.append(BrandlistModel(title: "Boutique Moschino"))
        aArray.append(BrandlistModel(title: "Champion"))
        aArray.append(BrandlistModel(title: "Diesel"))
        aArray.append(BrandlistModel(title: "Jack & Jones"))
        aArray.append(BrandlistModel(title: "Naf Naf"))
        aArray.append(BrandlistModel(title: "Red Valentino"))
        aArray.append(BrandlistModel(title: "s.Oliver"))

        return aArray
    
    }
}
