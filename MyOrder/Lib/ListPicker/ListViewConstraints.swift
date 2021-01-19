//
//  ListViewConstraints.swift
//  GWLListPicker
//
//  Created by sourabh on 21/05/20.
//  Copyright © 2020 Galaxyweblinks. All rights reserved.
//

import UIKit

extension ListView {
    func addSelfToSuperView(superView: UIWindow) {
        superView.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1.0, constant: 0))
        superView.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1.0, constant: 0))
        superView.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: 0))
        superView.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    func addBaseViewConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        // self.addConstraint(NSLayoutConstraint(item: popupView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: popupView, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 20))
        self.addConstraint(NSLayoutConstraint(item: popupView, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: -20))
        //        popupView.addConstraint(NSLayoutConstraint(item: popupView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        let top = NSLayoutConstraint(item: popupView, attribute: .top, relatedBy: .equal, toItem: safeArea, attribute: .top, multiplier: 1.0, constant: 20)
        let bottom = NSLayoutConstraint(item: popupView, attribute: .bottom, relatedBy: .equal, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: -20)
        //        top.priority = UILayoutPriority(rawValue: 800)
        //        bottom.priority = UILayoutPriority(rawValue: 800)
        self.addConstraint(top)
        self.addConstraint(bottom)
    }
    func titleBaseViewConstraints(titleView: UIView){
        popupView.addConstraint(NSLayoutConstraint(item: titleView, attribute: .leading, relatedBy: .equal, toItem: popupView, attribute: .leading, multiplier: 1.0, constant: 0))
        popupView.addConstraint(NSLayoutConstraint(item: titleView, attribute: .trailing, relatedBy: .equal, toItem: popupView, attribute: .trailing, multiplier: 1.0, constant: 0))
        popupView.addConstraint(NSLayoutConstraint(item: titleView, attribute: .top, relatedBy: .equal, toItem: popupView, attribute: .top, multiplier: 1.0, constant: 0))
        titleView.addConstraint(NSLayoutConstraint(item: titleView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
    }
    func titleLabelConstraints(titleLabel: UIView, byView: UIView){
        byView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: byView, attribute: .leading, multiplier: 1.0, constant: margin))
        byView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: byView, attribute: .trailing, multiplier: 1.0, constant: -margin))
        byView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: byView, attribute: .top, multiplier: 1.0, constant: margin))
        byView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: byView, attribute: .bottom, multiplier: 1.0, constant: -margin))
    }
    func buttonsBaseViewConstraints(buttonsView: UIView,direction: ButtonsDirection){
        popupView.addConstraint(NSLayoutConstraint(item: buttonsView, attribute: .leading, relatedBy: .equal, toItem: popupView, attribute: .leading, multiplier: 1.0, constant: 0))
        popupView.addConstraint(NSLayoutConstraint(item: buttonsView, attribute: .trailing, relatedBy: .equal, toItem: popupView, attribute: .trailing, multiplier: 1.0, constant: 0))
        popupView.addConstraint(NSLayoutConstraint(item: buttonsView, attribute: .bottom, relatedBy: .equal, toItem: popupView, attribute: .bottom, multiplier: 1.0, constant: 0))
        buttonsView.addConstraint(NSLayoutConstraint(item: buttonsView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: direction == .horizontal ? 60 : 120))
    }
    
    func buttonsButtonsConstraints(baseView: UIView, viewOne: UIView, viewSecond: UIView) {
        baseView.addConstraint(NSLayoutConstraint(item: viewOne, attribute: .leading, relatedBy: .equal, toItem: baseView, attribute: .leading, multiplier: 1.0, constant: margin))
        baseView.addConstraint(NSLayoutConstraint(item: viewOne, attribute: .top, relatedBy: .equal, toItem: baseView, attribute: .top, multiplier: 1.0, constant: margin))
        baseView.addConstraint(NSLayoutConstraint(item: viewSecond, attribute: .trailing, relatedBy: .equal, toItem: baseView, attribute: .trailing, multiplier: 1.0, constant: -margin))
        baseView.addConstraint(NSLayoutConstraint(item: viewSecond, attribute: .bottom, relatedBy: .equal, toItem: baseView, attribute: .bottom, multiplier: 1.0, constant: -margin))
        if aListConfiguration.aListButton.aDirection == .vertical {
            baseView.addConstraint(NSLayoutConstraint(item: viewOne, attribute: .trailing, relatedBy: .equal, toItem: baseView, attribute: .trailing, multiplier: 1.0, constant: -margin))
            baseView.addConstraint(NSLayoutConstraint(item: viewSecond, attribute: .leading, relatedBy: .equal, toItem: baseView, attribute: .leading, multiplier: 1.0, constant: margin))
            baseView.addConstraint(NSLayoutConstraint(item: viewSecond, attribute: .top, relatedBy: .equal, toItem: viewOne, attribute: .bottom, multiplier: 1.0, constant: margin))
            baseView.addConstraint(NSLayoutConstraint(item: viewSecond, attribute: .height, relatedBy: .equal, toItem: viewOne, attribute: .height, multiplier: 1.0, constant: 0))
        }else {
            baseView.addConstraint(NSLayoutConstraint(item: viewSecond, attribute: .width, relatedBy: .equal, toItem: viewOne, attribute: .width, multiplier: 1.0, constant: 0))
            baseView.addConstraint(NSLayoutConstraint(item: viewOne, attribute: .bottom, relatedBy: .equal, toItem: baseView, attribute: .bottom, multiplier: 1.0, constant: -margin))
            baseView.addConstraint(NSLayoutConstraint(item: viewSecond, attribute: .top, relatedBy: .equal, toItem: baseView, attribute: .top, multiplier: 1.0, constant: margin))
            baseView.addConstraint(NSLayoutConstraint(item: viewSecond, attribute: .leading, relatedBy: .equal, toItem: viewOne, attribute: .trailing, multiplier: 1.0, constant: margin))
        }
    }
    func applySameConstraints(oldView: UIView, newView: UIView){
        oldView.superview?.addConstraint(NSLayoutConstraint(item: newView, attribute: .leading, relatedBy: .equal, toItem: oldView, attribute: .leading, multiplier: 1.0, constant: 1))
        oldView.superview?.addConstraint(NSLayoutConstraint(item: newView, attribute: .trailing, relatedBy: .equal, toItem: oldView, attribute: .trailing, multiplier: 1.0, constant: 1))
        oldView.superview?.addConstraint(NSLayoutConstraint(item: newView, attribute: .top, relatedBy: .equal, toItem: oldView, attribute: .top, multiplier: 1.0, constant: 1))
        oldView.superview?.addConstraint(NSLayoutConstraint(item: newView, attribute: .bottom, relatedBy: .equal, toItem: oldView, attribute: .bottom, multiplier: 1.0, constant: 1))
    }
    func searchBaseViewConstraints(searchView: UIView, topView: UIView){
        popupView.addConstraint(NSLayoutConstraint(item: searchView, attribute: .leading, relatedBy: .equal, toItem: popupView, attribute: .leading, multiplier: 1.0, constant: 0))
        popupView.addConstraint(NSLayoutConstraint(item: searchView, attribute: .trailing, relatedBy: .equal, toItem: popupView, attribute: .trailing, multiplier: 1.0, constant: 0))
        popupView.addConstraint(NSLayoutConstraint(item: searchView, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1.0, constant: 0))
        searchView.addConstraint(NSLayoutConstraint(item: searchView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant:45))
    }
    func addSearchIconConstraints(searchIcon: UIView, searchBaseView: UIView){
        searchBaseView.addConstraint(NSLayoutConstraint(item: searchIcon, attribute: .centerY, relatedBy: .equal, toItem: searchBaseView, attribute: .centerY, multiplier: 1.0, constant: 0))
        searchBaseView.addConstraint(NSLayoutConstraint(item: searchIcon, attribute: aListConfiguration.aListSearch.aSearchIconSide == .left ? .leading : .trailing, relatedBy: .equal, toItem: searchBaseView, attribute: aListConfiguration.aListSearch.aSearchIconSide == .left ? .leading : .trailing, multiplier: 1.0, constant: aListConfiguration.aListSearch.aSearchIconSide == .left ? margin : -margin))
    }
    func addSearchTextFieldConstraints(searchTextField: UIView, searchBaseView: UIView, icon: UIView){
        searchBaseView.addConstraint(NSLayoutConstraint(item: searchTextField, attribute: .top, relatedBy: .equal, toItem: searchBaseView, attribute: .top, multiplier: 1.0, constant: margin))
        searchBaseView.addConstraint(NSLayoutConstraint(item: searchTextField, attribute: .bottom, relatedBy: .equal, toItem: searchBaseView, attribute: .bottom, multiplier: 1.0, constant: -margin))
        if aListConfiguration.aListSearch.aSearchIconSide == .left {
            searchBaseView.addConstraint(NSLayoutConstraint(item: searchTextField, attribute: .leading, relatedBy: .equal, toItem: icon, attribute: .trailing, multiplier: 1.0, constant: margin))
            searchBaseView.addConstraint(NSLayoutConstraint(item: searchTextField, attribute: .trailing, relatedBy: .equal, toItem: searchBaseView, attribute: .trailing, multiplier: 1.0, constant: -margin))
        }else {
            searchBaseView.addConstraint(NSLayoutConstraint(item: searchTextField, attribute: .trailing, relatedBy: .equal, toItem: icon, attribute: .leading, multiplier: 1.0, constant: -margin))
            searchBaseView.addConstraint(NSLayoutConstraint(item: searchTextField, attribute: .leading, relatedBy: .equal, toItem: searchBaseView, attribute: .leading, multiplier: 1.0, constant: margin))
        }
    }
    
    func addTableViewConstraints(tableTopView: UIView, tableBottomView: UIView) {
        popupView.addConstraint(NSLayoutConstraint(item: tableViewSearch, attribute: .leading, relatedBy: .equal, toItem: popupView, attribute: .leading, multiplier: 1.0, constant: 0))
        popupView.addConstraint(NSLayoutConstraint(item: tableViewSearch, attribute: .trailing, relatedBy: .equal, toItem: popupView, attribute: .trailing, multiplier: 1.0, constant: 0))
        popupView.addConstraint(NSLayoutConstraint(item: tableViewSearch, attribute: .top, relatedBy: .equal, toItem: tableTopView, attribute: .bottom, multiplier: 1.0, constant: 0))
        popupView.addConstraint(NSLayoutConstraint(item: tableViewSearch, attribute: .bottom, relatedBy: .equal, toItem: tableBottomView, attribute: .top, multiplier: 1.0, constant: 0))
    }
}
