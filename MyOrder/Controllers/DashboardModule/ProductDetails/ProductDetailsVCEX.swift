//
//  ProductDetailsVCEX.swift
//  MyOrder
//
//  Created by sourabh on 24/10/20.
//

import UIKit
extension ProductDetailsViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if sender == self.tagViewColor {
            tagViewColor.tagViews.forEach { tags in
                tags.isSelected = false
                tags.borderWidth = 0
                if self.aProductType == .unconfigurable && tags == tagView {
                    tags.isSelected = true
                    tags.borderWidth = 1
                }
            }
            if self.aProductType != .unconfigurable {
                self.getDependentSizes(tagView: tagView)
            }
        } else {
            tagView.isSelected = !tagView.isSelected
        }
    }
    func getDependentSizes(tagView: TagView) {
        self.refreshQty = true
        if self.aProductDetail.size_chart.count > 0 {
            self.tableViewSize.reloadData()
        }
        let colorId = self.aProductDetail.attribute.aColors[tagView.tag].fld_color_id
        self.getDependentSize(aProductId: aProductDetail.fld_product_id, aColorId: colorId, tagView: tagView)
    }
}
extension ProductDetailsViewController {
    func getProductDetails(){
        self.pagger.numberOfPages = 0
        if let product = self.aProduct {
            self.productDetailsServiceCall(aProductId: product.id, aColorId: product.color_id, aSizeId: product.size_id)
        }
        if let dashboardProduct = self.aDashboardProduct {
            self.productDetailsServiceCall(aProductId: dashboardProduct.id, aColorId: dashboardProduct.color_id, aSizeId: dashboardProduct.size_id)
        }
        if let wishlistModel = self.aWishlistModel {
            self.productDetailsServiceCall(aProductId: wishlistModel.fld_product_id, aColorId: wishlistModel.fld_color_id, aSizeId: wishlistModel.fld_size_id)
        }
    }
    func productDetailsServiceCall(aProductId: Int, aColorId: Int, aSizeId: Int){
        self.showActivity()
        self.aProductDetailsViewModel.getProductDetails(fld_product_id: aProductId, fld_color_id: aColorId, fld_size_id: aSizeId) { (model) in
            self.hideActivity()
            self.aProductDetailModel = model
            self.aProductDetail = self.aProductDetailModel.productDetail
            self.updateUi()
            if self.aProductType == .unconfigurable || self.aProductDetail.attribute.aColors.isEmpty == true {
                self.labelColor.text = ""
                self.tagViewColor.removeFromSuperview()
            }
            if self.aProductDetail.attribute.aSizes.isEmpty == true && self.aProductType != .unconfigurable{
                self.tableViewSize.removeFromSuperview()
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func wishListUpdateServiceCall(){
        self.showActivity()
        self.aProductListViewModel.wishlistServiceCall(aProductId: self.aProductDetail.fld_product_id, aWishListAdd: self.aProductDetail.isInWishlist) { (msg) in
            self.hideActivity()
            self.showAlartWith(message: msg)
            self.aProductDetail.isInWishlist = !self.aProductDetail.isInWishlist
            self.updateUi()
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    
    func getDependentSize(aProductId: Int, aColorId: Int, tagView: TagView){
        self.showActivity()
        self.aProductDetailsViewModel.getDependendSizeServiceCall(fld_product_id: aProductId,
                                                                  fld_color_id: aColorId) { (sizes) in
            self.refreshQty = false
            self.hideActivity()
            self.aProductDetail.attribute.aSizes = sizes
            self.tableViewSize.reloadData()
            tagView.isSelected = true
            tagView.borderWidth = 1
        } aFailed: { (error) in
            self.refreshQty = false
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func addToCartServiceCall(aProductId: Int, aManufactureId: Int, aQty: Int ,asizeId: Int? = 0, aColorId: Int? = 0){
        self.showActivity()
        let addcart = AddCart(aProductId: aProductId,
                              aManufactureId: aManufactureId,
                              aSizeId: asizeId,
                              aColorId: aColorId,
                              aProductQty: aQty)
        self.aCartViewModel.addToCartServiceCall(aAddCardModel: [addcart]) { (msg) in
            self.hideActivity()
            self.showAlartWith(message: msg)
            self.addRightBarButton()
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    
}

extension ProductDetailsViewController {
    func updateUi(){
        self.pagger.numberOfPages = self.aProductDetail.thumbnail.count
        self.buttonWishList.setImage(self.aProductDetail.isInWishlist == true ? UIImage(imageLiteralResourceName: "fav") : UIImage(imageLiteralResourceName: "unfav"), for: [])
        self.labelBrandName.text = self.aProductDetail.fld_brand_name
        self.labelName.text = self.aProductDetail.fld_product_name
        self.labelPrice.text = "₹" + self.aProductDetail.fld_product_spcl_price.description
        self.labelOldPrice.text = "₹" + self.aProductDetail.fld_product_price.description
        self.labelMinOrder.text = "*Min Order Quantity: " + self.aProductDetail.fld_product_moq.description
        self.labelSupplierName.text =  self.aProductDetail.fld_seller_info.fld_seller_name
        if let url = URL(string: self.aProductDetail.fld_product_long_description) {
            do {
                var contents = try String(contentsOf: url)
                if contents.contains("</script>") == true {
                    contents = ""
                }
                contents = contents.replacingOccurrences(of: "<p>", with: "")
                self.labelDiscription.text = contents.replacingOccurrences(of: "</p>", with: "")
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        
        var colors: [UIColor] = []
        tagViewColor?.removeAllTags()
        for aColor in self.aProductDetail.attribute.aColors {
            if let color = UIColor(hex: aColor.fld_color_code) {
                colors.append(color)
            }
        }
        tagViewColor?.addTagsColors(colors)
       
        if self.aProductDetail.attribute.aColors.isEmpty == true && self.aProductDetail.attribute.aSizes.isEmpty == true  {
            aProductType = .normal
            self.labelMinOrder.isHidden = true
            self.buttonAddUpdateCart.setTitle("ADD TO CART", for: .normal)
            self.labelSingleQty.isHidden = false
            self.textFieldQtySingle.isHidden = false
        } else if self.aProductDetail.attribute.aColors.isEmpty == true || self.aProductDetail.attribute.aSizes.isEmpty == true {
            aProductType = .unconfigurable
            self.labelSingleQty.isHidden = true
            self.textFieldQtySingle.isHidden = true
            self.buttonAddUpdateCart.setTitle("GO TO CART", for: .normal)
        }else {
            aProductType = .configurable
            self.labelSingleQty.isHidden = true
            self.textFieldQtySingle.isHidden = true
            self.buttonAddUpdateCart.setTitle("GO TO CART", for: .normal)
        }
        self.labelMinOrder.isHidden = false
        if self.aProductDetail.isInCart == true {
            self.buttonAddUpdateCart.setTitle("GO TO CART", for: .normal)
        }
        if UserModel.shared.aSelectedUserType == .manufacture {
            self.buttonAddUpdateCart.isHidden = true
        }
        
        self.collectionViewProduct.reloadData()
        self.tableViewSize?.reloadData()
    }
}
