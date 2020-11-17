//
//  ListView.swift
//  GWLListPicker
//
//  Created by gwl on 21/05/20.
//  Copyright © 2020 Galaxyweblinks. All rights reserved.
//

import UIKit

typealias ListComplition = (_ value: [String]?) -> Void

class ListView: UIView {
    
    let margin: CGFloat = 10.0

    var popupView = UIView()
    var aListConfiguration = ListConfiguration()
    var serachTextField = UITextField()
    var tableViewSearch = UITableView()
    var tableArray: [String] = []
    var listArray: [String] = []
    var tableSelectedArray: [String] = []
    var bottomView  = UIView()
    var complition: ListComplition? = nil

    init(aTableArray: [String], selectedArray: [String], configuration: ListConfiguration, aComplition: @escaping ListComplition) {
        super.init(frame: .zero)
        complition = aComplition
        tableArray = aTableArray
        tableSelectedArray = selectedArray
        aListConfiguration = configuration
        makeView()
        listArray = tableArray
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func makeView() {
        if  let window = UIApplication.shared.windows.first {
            self.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
            window.addSubview(self)
            self.translatesAutoresizingMaskIntoConstraints = false
            addSelfToSuperView(superView: window)
            self.addSubview(popupView)
            popupView.backgroundColor = .lightText
            popupView.clipsToBounds = true
            popupView.layer.cornerRadius = 10
            popupView.translatesAutoresizingMaskIntoConstraints = false
            addBaseViewConstraints()

            let topView = makeTopTitle()
            bottomView = makeBottomButtons()
            
            var searchBar = UIView()
            if aListConfiguration.aListSearch.shouldEnableSearch == true {
                searchBar = makeSearchBar(searchTopView: topView)
                serachTextField.delegate = self
                serachTextField.clearButtonMode = .whileEditing
            }
           
            tableViewSearch.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
            tableViewSearch.dataSource = self
            tableViewSearch.delegate = self
            tableViewSearch.rowHeight = UITableView.automaticDimension
            tableViewSearch.backgroundColor = self.aListConfiguration.backgroundColor
            tableViewSearch.estimatedRowHeight = 44
            addTableView(tableTopView: aListConfiguration.aListSearch.shouldEnableSearch ? searchBar : topView, tableBottomView: bottomView)
            tableViewSearch.reloadData()

            ListAnimation().showAnimation(inview: self, sheetView: popupView)
            tableViewSearch.reloadData()
            tableViewSearch.layoutIfNeeded()
            shouldEnableDoneButton()
        }
    }
    @objc func actionOnUpInside(_ sender: UIButton){
        if let subviews: [UIView] = sender.superview?.subviews  {
            for item in subviews {
                if sender.tag == item.tag {
                    if let label = item as? UILabel {
                        label.alpha = 1.0
                        break
                    }
                }
            }
        }
        if sender.tag == 202 {
            ListAnimation().hideAnimation(inview: self, sheetView: popupView)
        }
        if sender.tag == 201 {
           if let complition = self.complition {
            complition(tableSelectedArray)
            }
            ListAnimation().hideAnimation(inview: self, sheetView: popupView)

        }
    }
    @objc func actionOnUpOutside(_ sender: UIButton){
        if let subviews: [UIView] = sender.superview?.subviews  {
            for item in subviews {
                if sender.tag == item.tag {
                    if let label = item as? UILabel {
                        label.alpha = 0.5
                        break
                    }
                }
            }
        }
    }
    func shouldEnableDoneButton(){
        for item in bottomView.subviews {
            if item.tag == 201 {
                if let label = item as? UILabel {
                    if tableSelectedArray.isEmpty == true {
                        label.alpha = 0.3
                    }else {
                        label.alpha = 1.0
                    }
                }
                if let button = item as? UIButton {
                    if tableSelectedArray.isEmpty == true {
                        button.isUserInteractionEnabled = false
                    }else {
                        button.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
}

extension ListView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if result.contains("\n") { return true}
        if result.isEmpty {
            tableArray = listArray
        } else {
            tableArray = listArray.filter { ($0.lowercased().contains(result.lowercased())) }
        }
        tableViewSearch.reloadData()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
               self.tableArray = self.listArray
               self.tableViewSearch.reloadData()
           }
           return true
       }
}
