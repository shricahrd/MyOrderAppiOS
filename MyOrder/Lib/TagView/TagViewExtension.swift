//
//  TagViewExtension.swift
//  GWLTagList
//
//  Created by gwl on 26/05/20.
//  Copyright © 2020 gwl. All rights reserved.
//

import Foundation

extension TagListView {
    func setConfiguration(aTagConfiguration: TagViewConfigurations) {
        setTextColor(aTagTextColor: aTagConfiguration.tagViewTextColorObj)
        setBackGroundColor(aTagBackgroundColor: aTagConfiguration.tagViewBackGroundColorObj)
        setCornerRadius(aTagCornerRadius: aTagConfiguration.tagViewCornerRadiusObj)
        setTagViewPedding(aTagViewPedding: aTagConfiguration.tagViewSetPeddingObj)
        setRemoveButton(aTagViewRemoveButton: aTagConfiguration.tagViewRemoveTagObj)
        setTagMargin(aTagViewMargin: aTagConfiguration.tagViewMarginObj)
        setShadow(aTagViewShadow: aTagConfiguration.tagViewShadowObj)
    }
    func setTextColor(aTagTextColor: TagViewTextColor) {
        self.textColor = aTagTextColor.textColor
        self.selectedTextColor = aTagTextColor.selectedTagTextColor
    }
    func setBackGroundColor(aTagBackgroundColor: TagViewBackGroundColor) {
        self.tagBackgroundColor = aTagBackgroundColor.tagBackgroundColor
        self.tagSelectedBackgroundColor = aTagBackgroundColor.selectedTagBackgroundColor
        self.tagHighlightedBackgroundColor = aTagBackgroundColor.tagBackgroundColor
    }
    func setCornerRadius(aTagCornerRadius: TagViewCornerRadius) {
        self.cornerRadius = aTagCornerRadius.tagViewCornerRadius
        self.borderWidth = aTagCornerRadius.tagViewBorderWidth
        self.borderColor = aTagCornerRadius.tagViewBorderColor
        self.selectedBorderColor = aTagCornerRadius.selectedTagViewBorderColor
    }
    func setTagViewPedding(aTagViewPedding: TagViewSetPedding) {
        self.paddingX = aTagViewPedding.peddingX
        self.paddingY = aTagViewPedding.peddingY
    }
    func setShadow(aTagViewShadow: TagViewShadow) {
        self.shadowColor = aTagViewShadow.shadowColor
        self.shadowRadius = aTagViewShadow.shadowRadius
        self.shadowOffset = aTagViewShadow.shadowOffset
        self.shadowOpacity = aTagViewShadow.shadowOpacity
    }
    func setTagMargin(aTagViewMargin: TagViewMargin) {
        self.marginX = aTagViewMargin.marginX
        self.marginY = aTagViewMargin.marginY
    }
    func setRemoveButton(aTagViewRemoveButton: TagViewRemoveTag) {
        self.enableRemoveButton = aTagViewRemoveButton.removeButtonEnable
        self.removeImage = aTagViewRemoveButton.removeIconImage
        self.removeIconLineWidth = aTagViewRemoveButton.removeButtonWidth
    }
}
