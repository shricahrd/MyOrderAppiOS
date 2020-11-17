//
//  ListCreater.swift
//  GWLListPicker
//
//  Created by gwl on 21/05/20.
//  Copyright © 2020 Galaxyweblinks. All rights reserved.
//

import UIKit

extension ListView {
    func makeTopTitle() -> UIView {
        let titleBase = UIView()
        self.popupView.addSubview(titleBase)
        titleBase.backgroundColor = self.aListConfiguration.backgroundColor
        titleBase.translatesAutoresizingMaskIntoConstraints = false
        titleBaseViewConstraints(titleView: titleBase)
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.text = self.aListConfiguration.aListTitle.title
        titleLabel.font = UIFont(name: self.aListConfiguration.aListTitle.titleFontName, size: self.aListConfiguration.aListTitle.titleFontSize)
        titleLabel.textAlignment = .center
        titleLabel.textColor = self.aListConfiguration.aListTitle.titleColor
        titleLabel.backgroundColor = self.aListConfiguration.backgroundColor
        titleBase.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabelConstraints(titleLabel: titleLabel, byView: titleBase)
        
        return titleBase
    }
    func makeBottomButtons() -> UIView {
        let buttonsBase = UIView()
        self.popupView.addSubview(buttonsBase)
        buttonsBase.backgroundColor = self.aListConfiguration.backgroundColor
        buttonsBase.translatesAutoresizingMaskIntoConstraints = false
        buttonsBaseViewConstraints(buttonsView: buttonsBase, direction: aListConfiguration.aListButton.aDirection)
        
        let buttonLabel1 = UILabel()
        buttonLabel1.numberOfLines = 2
        buttonLabel1.text = self.aListConfiguration.aListButton.doneButtonTitle
        buttonLabel1.font = UIFont(name: self.aListConfiguration.aListButton.buttonFontName, size: self.aListConfiguration.aListButton.buttonFontSize)
        buttonLabel1.textColor = self.aListConfiguration.hightLightColor
        buttonLabel1.layer.borderWidth = 2.0
        buttonLabel1.layer.borderColor = self.aListConfiguration.hightLightColor.cgColor
        buttonLabel1.backgroundColor = self.aListConfiguration.backgroundColor
       
        buttonLabel1.tag = 201
        buttonLabel1.layer.cornerRadius = 10
        buttonLabel1.clipsToBounds = true
        buttonLabel1.textAlignment = .center
        buttonsBase.addSubview(buttonLabel1)
        buttonLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonLabel2 = UILabel()
        buttonLabel2.numberOfLines = 2
        buttonLabel2.text = self.aListConfiguration.aListButton.cancelButtonTitle
        buttonLabel2.font = UIFont(name: self.aListConfiguration.aListButton.buttonFontName, size: self.aListConfiguration.aListButton.buttonFontSize)
        buttonLabel2.tag = 202
        buttonLabel2.layer.cornerRadius = 10
        buttonLabel2.clipsToBounds = true
        buttonLabel2.textAlignment = .center
        
        buttonLabel2.textColor = self.aListConfiguration.backgroundColor
        buttonLabel2.backgroundColor = self.aListConfiguration.hightLightColor
        
        buttonsBase.addSubview(buttonLabel2)
        buttonLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsButtonsConstraints(baseView: buttonsBase,viewOne: buttonLabel1, viewSecond: buttonLabel2)
        makeButtonForClick(aButtonLabel: buttonLabel1)
        makeButtonForClick(aButtonLabel: buttonLabel2)

        return buttonsBase
    }
    func makeButtonForClick(aButtonLabel: UIView) {
        let button = UIButton()
        button.setTitle("", for: [])
        button.tag = aButtonLabel.tag
        button.backgroundColor = .clear
        aButtonLabel.superview?.addSubview(button)
        button.addTarget(self, action: #selector(self.actionOnUpOutside(_:)), for: .allTouchEvents)
        button.addTarget(self, action: #selector(self.actionOnUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        applySameConstraints(oldView: aButtonLabel, newView: button)
    }
    func makeSearchBar(searchTopView: UIView) -> UIView{
        let searchBase = UIView()
        self.popupView.addSubview(searchBase)
        searchBase.backgroundColor = UIColor(named: "AppCellGray")//self.aListConfiguration.hightLightColor
        searchBase.translatesAutoresizingMaskIntoConstraints = false
        searchBaseViewConstraints(searchView: searchBase, topView: searchTopView)
        
        let seachIcon = UIImageView()
        seachIcon.image = aListConfiguration.aListSearch.serachIconImage
        seachIcon.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)
        seachIcon.backgroundColor = .clear
        seachIcon.contentMode = .scaleAspectFit
        searchBase.addSubview(seachIcon)
        seachIcon.translatesAutoresizingMaskIntoConstraints = false
        addSearchIconConstraints(searchIcon: seachIcon, searchBaseView: searchBase)

        serachTextField.backgroundColor = .clear
        serachTextField.placeholder = aListConfiguration.aListSearch.serachPlaceHolder
        serachTextField.font = UIFont(name: self.aListConfiguration.aListSearch.serachFieldFontName, size: self.aListConfiguration.aListSearch.serachFieldFontSize)
        serachTextField.textColor = aListConfiguration.aListSearch.serachFieldTextColor
        searchBase.addSubview(serachTextField)
        serachTextField.translatesAutoresizingMaskIntoConstraints = false
        addSearchTextFieldConstraints(searchTextField: serachTextField, searchBaseView: searchBase, icon: seachIcon)
        
        return searchBase
    }
    func addTableView(tableTopView: UIView, tableBottomView: UIView) {
        self.popupView.addSubview(tableViewSearch)
        tableViewSearch.translatesAutoresizingMaskIntoConstraints = false
        addTableViewConstraints(tableTopView: tableTopView, tableBottomView: tableBottomView)
    }
}
