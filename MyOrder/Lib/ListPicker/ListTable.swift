//
//  ListTable.swift
//  GWLListPicker
//
//  Created by gwl on 22/05/20.
//  Copyright © 2020 Galaxyweblinks. All rights reserved.
//

import UIKit

enum CellIconSide {
    case left
    case right
}
class SearchResultCell: UITableViewCell {
    static let identifier = "SearchResultCell"
    let baseView = UIView()
    var imageViewCheck = UIImageView()
    var labelMessage = UILabel()
    var margin: CGFloat = 10
    var aCellIconSide: CellIconSide = .left
    var aCellSelection: Bool = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
extension SearchResultCell{
    func addBaseView(){
        baseView.backgroundColor = .clear
        baseView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(baseView)
        addBaseViewConstraint()
        if aCellSelection == false {
            addIcon()
        }
        addLabel()
    }
    func addIcon(){
        imageViewCheck.backgroundColor = .clear
        imageViewCheck.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(imageViewCheck)
        addIconConstraints()
    }
    func addLabel(){
        labelMessage.backgroundColor = .clear
        labelMessage.numberOfLines = 0
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(labelMessage)
        addLabelViewConstraint()
    }
}
extension SearchResultCell{
    func addBaseViewConstraint()  {
        self.contentView.addConstraint(NSLayoutConstraint(item: baseView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: baseView, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: baseView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 5))
        self.contentView.addConstraint(NSLayoutConstraint(item: baseView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: -5))
        baseView.addConstraint(NSLayoutConstraint(item: baseView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    }
    func addLabelViewConstraint()  {
        baseView.addConstraint(NSLayoutConstraint(item: labelMessage, attribute: .top, relatedBy: .equal, toItem: baseView, attribute: .top, multiplier: 1.0, constant: margin))
        baseView.addConstraint(NSLayoutConstraint(item: labelMessage, attribute: .bottom, relatedBy: .equal, toItem: baseView, attribute: .bottom, multiplier: 1.0, constant: -margin))
        if aCellIconSide == .left {
            baseView.addConstraint(NSLayoutConstraint(item: labelMessage, attribute: .leading, relatedBy: .equal, toItem: aCellSelection ? baseView : imageViewCheck, attribute: aCellSelection ? .leading : .trailing, multiplier: 1.0, constant: margin))
            baseView.addConstraint(NSLayoutConstraint(item: labelMessage, attribute: .trailing, relatedBy: .equal, toItem: baseView, attribute: .trailing, multiplier: 1.0, constant: -margin))
        }else {
            baseView.addConstraint(NSLayoutConstraint(item: labelMessage, attribute: .trailing, relatedBy: .equal, toItem: aCellSelection ? baseView : imageViewCheck, attribute: aCellSelection ? .trailing : .leading, multiplier: 1.0, constant: -margin))
            baseView.addConstraint(NSLayoutConstraint(item: labelMessage, attribute: .leading, relatedBy: .equal, toItem: baseView, attribute: .leading, multiplier: 1.0, constant: margin))
        }
    }
    func addIconConstraints(){
        baseView.addConstraint(NSLayoutConstraint(item: imageViewCheck, attribute: .centerY, relatedBy: .equal, toItem: baseView, attribute: .centerY, multiplier: 1.0, constant: 0))
        baseView.addConstraint(NSLayoutConstraint(item: imageViewCheck, attribute: aCellIconSide == .left ? .leading : .trailing, relatedBy: .equal, toItem: baseView, attribute: aCellIconSide == .left ? .leading : .trailing, multiplier: 1.0, constant: aCellIconSide == .left ? margin : -margin))
    }
}
extension ListView: UITableViewDataSource,UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell
        cell.margin = self.margin
        cell.aCellIconSide = self.aListConfiguration.aListCell.aCellIconSide
        cell.imageViewCheck.image = self.aListConfiguration.aListCell.selectIconImage
        cell.aCellSelection = self.aListConfiguration.aListCell.cellSelection
        cell.contentView.backgroundColor = self.aListConfiguration.backgroundColor
        cell.addBaseView()
        let comingObject = self.tableArray[indexPath.row]
        cell.labelMessage.text = comingObject
        cell.labelMessage.textColor = self.aListConfiguration.aListCell.cellTextColor
        cell.labelMessage.font = UIFont(name: self.aListConfiguration.aListCell.cellTextFontName, size: self.aListConfiguration.aListCell.cellTextFontSize)
        if self.tableSelectedArray.contains(comingObject) == true {
            if self.aListConfiguration.aListCell.cellSelection == true {
                cell.baseView.backgroundColor = self.aListConfiguration.hightLightColor
            }else{
                cell.imageViewCheck.image = self.aListConfiguration.aListCell.selectIconImage
            }
        } else {
            if self.aListConfiguration.aListCell.cellSelection == true {
                cell.baseView.backgroundColor = self.aListConfiguration.backgroundColor
            }else {
                cell.imageViewCheck.image = self.aListConfiguration.aListCell.unSelectIconImage
            }
        }
        cell.selectionStyle = .none

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comingObject = self.tableArray[indexPath.row]
        if self.aListConfiguration.aListCell.singleSelection == true && !self.tableSelectedArray.contains(comingObject){
            self.tableSelectedArray.removeAll()
        }
        if self.tableSelectedArray.contains(comingObject) == true {
            tableSelectedArray.remove(at: self.tableSelectedArray.firstIndex(of: comingObject)!)
        }else {
            tableSelectedArray.append(comingObject)
        }
        self.tableViewSearch.reloadData()
        self.shouldEnableDoneButton()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
