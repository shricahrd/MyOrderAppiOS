//
//  FilterViewController.swift
//  MyOrder
//
//  Created by sourabh on 12/10/20.
//

import UIKit
import RangeSeekSlider

class FilterViewController: BaseViewController  {
    @IBOutlet weak var viewCategory: TagListView!
    @IBOutlet weak var viewColor: TagListView!
    @IBOutlet weak var viewSize: TagListView!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    @IBOutlet weak var LabletitleCategory: UILabel!
    @IBOutlet weak var LabletitleColor: UILabel!
    @IBOutlet weak var LabletitleSize: UILabel!
    
    var aFilterViewModel = FilterViewModel()
    var aFilterModel: FilterModel? = nil
    var aCatagoryId = 0
    var aSearchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.filterServiceCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.updateUi()
    }
    @IBAction func actionOnBrand(_ sender: Any) {
        if let  aBrandlistViewController = BrandlistViewController.getController(story: "Dashboard")  as? BrandlistViewController {
            aBrandlistViewController.tableArray = self.aFilterModel?.aBranddata ?? []
            self.navigationController?.pushViewController(aBrandlistViewController, animated: true)
        }
    }
    override func actionOnLeftIcon(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnClearAll(_ sender: Any) {
        for controller in self.navigationController!.viewControllers {
            if let vc = controller as? ProductListViewController {
                vc.aFilterModel = nil
                vc.currentPageNo = 0
                break
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnApply(_ sender: Any) {
        self.aFilterModel?.aPricedata.max_price_value = Int(self.rangeSlider.selectedMaxValue)
        self.aFilterModel?.aPricedata.min_price_value = Int(self.rangeSlider.selectedMinValue)
        for controller in self.navigationController!.viewControllers {
            if let vc = controller as? ProductListViewController {
                vc.aFilterModel = self.aFilterModel
                vc.currentPageNo = 0
                break
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension FilterViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if sender == self.viewColor {
            tagView.isSelected = !tagView.isSelected
            if tagView.isSelected == true {
                tagView.borderWidth = 1
            }else {
                tagView.borderWidth = 0
            }
            self.aFilterModel?.aColordata[tagView.tag].isSelected = tagView.isSelected
        } else if sender == self.viewCategory {
            tagView.isSelected = !tagView.isSelected
            self.aFilterModel?.aCategorydata[tagView.tag].isSelected = tagView.isSelected
        } else if sender == self.viewSize {
            tagView.isSelected = !tagView.isSelected
            self.aFilterModel?.aSizedata[tagView.tag].isSelected = tagView.isSelected
        }
    }
}

extension FilterViewController {
    func filterServiceCall() {
        if self.aFilterModel != nil {
            self.updateUi()
        }else {
            self.showActivity()
            self.aFilterViewModel.getFilterss(afld_brand_id: 0,
                                              afld_cat_id:aCatagoryId,
                                              afld_search_txt: aSearchText) { (model) in
                self.hideActivity()
                self.aFilterModel = model
                self.updateUi()
            } aFailed: { (error) in
                self.hideActivity()
                self.showAlartWith(message: error!.localizedDescription)
            }
        }
    }
    func updateUi() {
        if let aaFilterModel = self.aFilterModel {
            var category: [String] = []
            viewCategory.textFont = UIFont.systemFont(ofSize: 14.0)
            viewCategory.removeAllTags()
            for aCategory in aaFilterModel.aCategorydata {
                category.append(aCategory.fld_cat_name)
            }
            viewCategory.addTags(category)
            
            for (index,aCategory) in aaFilterModel.aCategorydata.enumerated() {
                viewCategory.tagViews[index].isSelected = aCategory.isSelected
            }
            
            var colors: [UIColor] = []
            viewColor.removeAllTags()
            for aColor in aaFilterModel.aColordata {
                if let color = UIColor(hex: aColor.fld_code) {
                    colors.append(color)
                }
            }
            viewColor.addTagsColors(colors)
            for (index,aColor) in aaFilterModel.aColordata.enumerated() {
                if let _ = UIColor(hex: aColor.fld_code) {
                    viewColor.tagViews[index].isSelected = aColor.isSelected
                    if viewColor.tagViews[index].isSelected == true {
                        viewColor.tagViews[index].borderWidth = 1
                    }else {
                        viewColor.tagViews[index].borderWidth = 0
                    }
                }
            }
            
            var sizes: [String] = []
            viewSize.textFont = UIFont.systemFont(ofSize: 14.0)
            viewSize.removeAllTags()
            for asizes in aaFilterModel.aSizedata {
                sizes.append(asizes.fld_name)
            }
            viewSize.addTags(sizes)
            for (index,asizes) in aaFilterModel.aSizedata.enumerated() {
                viewSize.tagViews[index].isSelected = asizes.isSelected
            }
            
            self.rangeSlider.minValue = CGFloat(aaFilterModel.aPricedata.min_price)
            self.rangeSlider.maxValue = CGFloat(aaFilterModel.aPricedata.max_price)
            self.rangeSlider.selectedMinValue = CGFloat(aaFilterModel.aPricedata.min_price_value)
            self.rangeSlider.selectedMaxValue = CGFloat(aaFilterModel.aPricedata.max_price_value)
            
            if aaFilterModel.aCategorydata.count <= 0 {
                self.viewCategory.removeFromSuperview()
                self.LabletitleCategory.removeFromSuperview()
            }
            if aaFilterModel.aSizedata.count <= 0 {
                self.viewSize.removeFromSuperview()
                self.LabletitleSize.removeFromSuperview()
            }
            if aaFilterModel.aColordata.count <= 0 {
                self.viewColor.removeFromSuperview()
                self.LabletitleColor.removeFromSuperview()
            }
        }
    }
}
