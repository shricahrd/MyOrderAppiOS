//
//  ListConfiguration.swift
//  GWLListPicker
//
//  Created by sourabh on 25/05/20.
//  Copyright © 2020 Galaxyweblinks. All rights reserved.
//

import UIKit

enum ButtonsDirection {
    case horizontal
    case vertical
}
enum SearchIconSide {
    case left
    case right
}
class ListConfiguration {

    var backgroundColor: UIColor = .white
    var hightLightColor: UIColor = .lightGray
    var aListTitle = ListTitle()
    var aListSearch = ListSearch()
    var aListCell = ListCell()
    var aListButton = ListButton()
    
    init() {}
    init(aBackgroundColor: UIColor, aHightLightColor: UIColor) {
        backgroundColor = aBackgroundColor
        hightLightColor = aHightLightColor
    }
    init(aBackgroundColor: UIColor, aHightLightColor: UIColor, listTitle: ListTitle?, listSearch: ListSearch?, listCell: ListCell?, listButton: ListButton?) {
        backgroundColor = aBackgroundColor
        hightLightColor = aHightLightColor
        if let title = listTitle { aListTitle = title }
        if let search = listSearch { aListSearch = search }
        if let cell = listCell { aListCell = cell }
        if let buttom = listButton { aListButton = buttom }
    }
}
class ListTitle {
    var title: String = "List Picker"
    var titleColor: UIColor = .black
    var titleFontName: String = "Roboto"
    var titleFontSize: CGFloat  = 17.0
    init() {}
    init(aTitle: String) {
        title = aTitle
    }
    init(aTitle: String, atitleColor: UIColor) {
        title = aTitle
        titleColor = atitleColor
    }
    init(aTitle: String, aTitleColor: UIColor, aTitleFontName: String, aTitleFontSize: CGFloat) {
        title = aTitle
        titleColor = aTitleColor
        titleFontName = aTitleFontName
        titleFontSize = aTitleFontSize
    }
}
class ListSearch {
    var shouldEnableSearch: Bool = true
    var serachIconImage: UIImage = #imageLiteral(resourceName: "searchicon")
    var aSearchIconSide: SearchIconSide = .right
    var serachPlaceHolder: String = "Search here."
    var serachFieldTextColor: UIColor = .black
    var serachFieldFontName: String = "Roboto"
    var serachFieldFontSize: CGFloat  = 17.0
    init() {}
    init(aShouldEnableSearch: Bool, searchIcom: UIImage?) {
        shouldEnableSearch = aShouldEnableSearch
        serachIconImage = searchIcom ?? #imageLiteral(resourceName: "searchicon")
    }
    init(aShouldEnableSearch: Bool, searchIcom: UIImage?, searchIconSide: SearchIconSide) {
        shouldEnableSearch = aShouldEnableSearch
        serachIconImage = searchIcom ?? #imageLiteral(resourceName: "searchicon")
        aSearchIconSide = searchIconSide
    }
    init(aShouldEnableSearch: Bool, searchIcom: UIImage?, searchIconSide: SearchIconSide, aSerachPlaceHolder: String) {
        shouldEnableSearch = aShouldEnableSearch
        serachIconImage = searchIcom ?? #imageLiteral(resourceName: "searchOutline")
        aSearchIconSide = searchIconSide
        serachPlaceHolder = aSerachPlaceHolder
    }
    init(aShouldEnableSearch: Bool, searchIcom: UIImage?, searchIconSide: SearchIconSide, aSerachPlaceHolder: String, aSerachFieldTextColor: UIColor) {
        shouldEnableSearch = aShouldEnableSearch
        serachIconImage = searchIcom ?? #imageLiteral(resourceName: "searchOutline")
        aSearchIconSide = searchIconSide
        serachPlaceHolder = aSerachPlaceHolder
        serachFieldTextColor = aSerachFieldTextColor
    }
    init(aShouldEnableSearch: Bool, searchIcom: UIImage?, searchIconSide: SearchIconSide, aSerachPlaceHolder: String, aSerachFieldTextColor: UIColor, aSerachFieldFontName : String, aSerachFieldFontSize: CGFloat) {
        shouldEnableSearch = aShouldEnableSearch
        serachIconImage = searchIcom ?? #imageLiteral(resourceName: "searchOutline")
        aSearchIconSide = searchIconSide
        serachPlaceHolder = aSerachPlaceHolder
        serachFieldTextColor = aSerachFieldTextColor
        serachFieldFontName = aSerachFieldFontName
        serachFieldFontSize = aSerachFieldFontSize
    }
}
class ListCell {
    let selectCheckIconImage: UIImage = #imageLiteral(resourceName: "checkList")
    let unSelectCheckIconImage: UIImage = #imageLiteral(resourceName: "uncheckList")
    let selectListIconImage: UIImage = #imageLiteral(resourceName: "checkList")
    let unSelectListIconImage: UIImage = #imageLiteral(resourceName: "uncheckList")
    var selectIconImage: UIImage? = nil
    var unSelectIconImage: UIImage? = nil
    var cellSelection: Bool = false
    var singleSelection: Bool = false
    var aCellIconSide: CellIconSide = .right
    var cellTextColor: UIColor = .black
    var cellTextFontName: String = "Roboto"
    var cellTextFontSize: CGFloat  = 17.0
    init() {
       setDefaultImage()
    }
    init(aSingleSelection : Bool, aCellSelection: Bool) {
        cellSelection = aCellSelection
        singleSelection = aSingleSelection
        setDefaultImage()
    }
    init(aSingleSelection : Bool, aCellSelection: Bool, cellIconSide: CellIconSide) {
        cellSelection = aCellSelection
        singleSelection = aSingleSelection
        aCellIconSide = cellIconSide
        setDefaultImage()
    }
    init(aSingleSelection : Bool, aCellSelection: Bool, cellIconSide: CellIconSide, aCellTextColor: UIColor) {
        cellSelection = aCellSelection
        singleSelection = aSingleSelection
        aCellIconSide = cellIconSide
        cellTextColor = aCellTextColor
        setDefaultImage()
    }
    init(aSingleSelection : Bool, aCellSelection: Bool, cellIconSide: CellIconSide, aCellTextColor: UIColor, aSelectIconImage: UIImage, aUnSelectIconImage: UIImage) {
        cellSelection = aCellSelection
        singleSelection = aSingleSelection
        aCellIconSide = cellIconSide
        cellTextColor = aCellTextColor
        selectIconImage = aSelectIconImage
        unSelectIconImage = aUnSelectIconImage
    }
    init(aSingleSelection : Bool, aCellSelection: Bool, cellIconSide: CellIconSide, aCellTextColor: UIColor, aCellTextFontName: String, aCellTextFontSize: CGFloat) {
        cellSelection = aCellSelection
        singleSelection = aSingleSelection
        aCellIconSide = cellIconSide
        cellTextColor = aCellTextColor
        cellTextFontName = aCellTextFontName
        cellTextFontSize = aCellTextFontSize
        setDefaultImage()
    }
    init(aSingleSelection : Bool, aCellSelection: Bool, cellIconSide: CellIconSide, aCellTextColor: UIColor, aSelectIconImage: UIImage, aUnSelectIconImage: UIImage, aCellTextFontName: String, aCellTextFontSize: CGFloat) {
        cellSelection = aCellSelection
        singleSelection = aSingleSelection
        aCellIconSide = cellIconSide
        cellTextColor = aCellTextColor
        selectIconImage = aSelectIconImage
        unSelectIconImage = aUnSelectIconImage
        cellTextFontName = aCellTextFontName
        cellTextFontSize = aCellTextFontSize
    }
    func setDefaultImage() {
        if selectIconImage == nil && unSelectIconImage == nil && cellSelection == false {
            selectIconImage = singleSelection ? selectCheckIconImage : selectListIconImage
            unSelectIconImage = singleSelection ? unSelectCheckIconImage : unSelectListIconImage
        }
    }
}
class ListButton {
    var aDirection: ButtonsDirection = .horizontal
    var cancelButtonTitle: String  = "Cancel"
    var doneButtonTitle: String  = "Done"
    var buttonFontName: String = "Roboto"
    var buttonFontSize: CGFloat  = 17.0
    init() {}
    init(direction: ButtonsDirection) {
        aDirection = direction
    }
    init(direction: ButtonsDirection, aCancelButtonTitle: String, aDoneButtonTitle: String) {
        aDirection = direction
        cancelButtonTitle = aCancelButtonTitle
        doneButtonTitle = aDoneButtonTitle
    }
    init(direction: ButtonsDirection, aCancelButtonTitle: String, aDoneButtonTitle: String, aButtonFontName: String, aButtonFontSize: CGFloat) {
        aDirection = direction
        cancelButtonTitle = aCancelButtonTitle
        doneButtonTitle = aDoneButtonTitle
        buttonFontName = aButtonFontName
        buttonFontSize = aButtonFontSize
    }
}
