//
//  GWLListPicker.swift
//  GWLListPicker
//
//  Created by gwl on 21/05/20.
//  Copyright © 2020 Galaxyweblinks. All rights reserved.
//

import UIKit

class GWLListPicker {
    public static let shared = GWLListPicker()
    
    func showNormal(title: String, tableArray: [String], backgroundColor: UIColor, highLightColor: UIColor, complition: @escaping ListComplition){
        let listTitle = ListTitle(aTitle: title)
      
        let listSearch = ListSearch(aShouldEnableSearch: false, searchIcom: nil)
      
        let confic =  ListConfiguration(aBackgroundColor: backgroundColor, aHightLightColor: highLightColor, listTitle: listTitle, listSearch: listSearch, listCell: nil, listButton: nil)
       
        
        _ = ListView(aTableArray: tableArray, selectedArray: [], configuration: confic, aComplition: complition)
    }
    
    func showSearch(title: String, tableArray: [String], backgroundColor: UIColor, highLightColor: UIColor, complition: @escaping ListComplition){
        let listTitle = ListTitle(aTitle: title)
        let listSearch = ListSearch(aShouldEnableSearch: true, searchIcom: nil)
        let confic =  ListConfiguration(aBackgroundColor: backgroundColor, aHightLightColor: highLightColor, listTitle: listTitle, listSearch: listSearch, listCell: nil, listButton: nil)
        _ = ListView(aTableArray: tableArray, selectedArray: [], configuration: confic, aComplition: complition)
    }
    
    
    func showChangeColor(title: String, tableArray: [String], backgroundColor: UIColor, highLightColor: UIColor, complition: @escaping ListComplition){
        let listTitle = ListTitle(aTitle: title)
        let listSearch = ListSearch(aShouldEnableSearch: true, searchIcom: nil)
        let confic =  ListConfiguration(aBackgroundColor: backgroundColor, aHightLightColor: highLightColor, listTitle: listTitle, listSearch: listSearch, listCell: nil, listButton: nil)
        _ = ListView(aTableArray: tableArray, selectedArray: [], configuration: confic, aComplition: complition)
    }
    
    
    func showChangeDirection(title: String, tableArray: [String], backgroundColor: UIColor, highLightColor: UIColor, complition: @escaping ListComplition){
        let listTitle = ListTitle(aTitle: title)
        let listSearch = ListSearch(aShouldEnableSearch: true, searchIcom: nil, searchIconSide: .left)
        let listCell = ListCell(aSingleSelection: false, aCellSelection: false, cellIconSide: .left)
        
        let confic =  ListConfiguration(aBackgroundColor: backgroundColor, aHightLightColor: highLightColor, listTitle: listTitle, listSearch: listSearch, listCell: listCell, listButton: nil)
        _ = ListView(aTableArray: tableArray, selectedArray: [], configuration: confic, aComplition: complition)
    }
    
    
    
    func showSingleSelect(title: String, tableArray: [String], selected: [String],backgroundColor: UIColor, highLightColor: UIColor, complition: @escaping ListComplition){
        let listTitle = ListTitle(aTitle: title)
        let listSearch = ListSearch(aShouldEnableSearch: true, searchIcom: nil, searchIconSide: .left)
        let listCell = ListCell(aSingleSelection: true, aCellSelection: false, cellIconSide: .left)
        let confic =  ListConfiguration(aBackgroundColor: backgroundColor, aHightLightColor: highLightColor, listTitle: listTitle, listSearch: listSearch, listCell: listCell, listButton: nil)
        _ = ListView(aTableArray: tableArray, selectedArray: selected, configuration: confic, aComplition: complition)
    }
    
    
    
    func showCellSelect(title: String, tableArray: [String], backgroundColor: UIColor, highLightColor: UIColor, complition: @escaping ListComplition){
        let listTitle = ListTitle(aTitle: title)
        let listSearch = ListSearch(aShouldEnableSearch: true, searchIcom: nil)
        
        let listCell = ListCell(aSingleSelection: true, aCellSelection: true)
        
        
        let confic =  ListConfiguration(aBackgroundColor: backgroundColor, aHightLightColor: highLightColor, listTitle: listTitle, listSearch: listSearch, listCell: listCell, listButton: nil)
        _ = ListView(aTableArray: tableArray, selectedArray: [], configuration: confic, aComplition: complition)
    }
    func showCellMultiSelect(title: String, tableArray: [String], backgroundColor: UIColor, highLightColor: UIColor, complition: @escaping ListComplition){
        let listTitle = ListTitle(aTitle: title)
        let listSearch = ListSearch(aShouldEnableSearch: true, searchIcom: nil)
        
        let listCell = ListCell(aSingleSelection: false, aCellSelection: true)
        
        
        let confic =  ListConfiguration(aBackgroundColor: backgroundColor, aHightLightColor: highLightColor, listTitle: listTitle, listSearch: listSearch, listCell: listCell, listButton: nil)
        _ = ListView(aTableArray: tableArray, selectedArray: [], configuration: confic, aComplition: complition)
    }
    
    func showButtonDirection(title: String, tableArray: [String], backgroundColor: UIColor, highLightColor: UIColor, complition: @escaping ListComplition){
        let listTitle = ListTitle(aTitle: title)
        let listSearch = ListSearch(aShouldEnableSearch: true, searchIcom: nil, searchIconSide: .left)
        let listCell = ListCell(aSingleSelection: true, aCellSelection: false, cellIconSide: .left)
        let listButton = ListButton(direction: .vertical)
        
        let confic =  ListConfiguration(aBackgroundColor: backgroundColor, aHightLightColor: highLightColor, listTitle: listTitle, listSearch: listSearch, listCell: listCell, listButton: listButton)
        _ = ListView(aTableArray: tableArray, selectedArray: [], configuration: confic, aComplition: complition)
    }
    
    func showSelectedArray(title: String, tableArray: [String],selected: [String], backgroundColor: UIColor, highLightColor: UIColor, complition: @escaping ListComplition){
        let listTitle = ListTitle(aTitle: title)
        let listSearch = ListSearch(aShouldEnableSearch: true, searchIcom: nil, searchIconSide: .left)
        let listCell = ListCell(aSingleSelection: false, aCellSelection: false, cellIconSide: .left)
        let listButton = ListButton(direction: .vertical)
        
        let confic =  ListConfiguration(aBackgroundColor: backgroundColor, aHightLightColor: highLightColor, listTitle: listTitle, listSearch: listSearch, listCell: listCell, listButton: listButton)
        _ = ListView(aTableArray: tableArray, selectedArray: selected, configuration: confic, aComplition: complition)
    }
}
