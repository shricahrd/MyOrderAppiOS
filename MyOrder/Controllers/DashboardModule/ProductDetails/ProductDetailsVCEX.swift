//
//  ProductDetailsVCEX.swift
//  MyOrder
//
//  Created by gwl on 24/10/20.
//

import UIKit
extension ProductDetailsViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if sender == self.tagViewColor {
            tagViewColor.tagViews.forEach { tags in
                tags.isSelected = false
                tags.borderWidth = 0
            }
            self.getDependentSizes(tagView: tagView)
        } else {
            tagView.isSelected = !tagView.isSelected
        }
    }
    func getDependentSizes(tagView: TagView) {
        self.refreshQty = true
        self.tableViewSize.reloadData()
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
            if self.aProductDetail.attribute.aColors.isEmpty == true {
                self.labelColor.text = ""
                self.tagViewColor.removeFromSuperview()
            }
            if self.aProductDetail.attribute.aSizes.isEmpty == true {
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
            tagView.borderWidth = 3
        } aFailed: { (error) in
            self.refreshQty = false
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func addToCartServiceCall(aProductId: Int, aManufactureId: Int, aQty: Int ,asizeId: Int? = nil, aColorId: Int? = nil){
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
        self.labelDiscription.text = self.aProductDetail.fld_product_long_description
        var colors: [UIColor] = []
        tagViewColor?.removeAllTags()
        for aColor in self.aProductDetail.attribute.aColors {
            if let color = UIColor(hex: aColor.fld_color_code) {
                colors.append(color)
            }
        }
        tagViewColor?.addTagsColors(colors)
        self.collectionViewProduct.reloadData()
        self.tableViewSize?.reloadData()
        if self.aProductDetail.attribute.aColors.isEmpty == true && self.aProductDetail.attribute.aSizes.isEmpty == true  {
            aProductType = .normal
        } else if self.aProductDetail.attribute.aColors.isEmpty == true || self.aProductDetail.attribute.aSizes.isEmpty == true {
            aProductType = .unconfigurable
        }else {
            aProductType = .configurable
        }
        if aProductType == .configurable {
            self.buttonAddUpdateCart.setTitle("GO TO CART", for: .normal)
        }else {
            self.buttonAddUpdateCart.setTitle("ADD TO CART", for: .normal)
        }
        if self.aProductDetail.isInCart == true {
            self.buttonAddUpdateCart.setTitle("GO TO CART", for: .normal)
        }
    }
}
