//
//  TagViewConfigurations.swift
//  GWLTagList
//
//  Created by gwl on 22/05/20.
//  Copyright © 2020 gwl. All rights reserved.
//

import UIKit
import Foundation

class TagViewConfigurations {
    var tagViewTextColorObj = TagViewTextColor()
    var tagViewBackGroundColorObj = TagViewBackGroundColor()
    var tagViewCornerRadiusObj = TagViewCornerRadius()
    var tagViewSetPeddingObj = TagViewSetPedding()
    var tagViewRemoveTagObj = TagViewRemoveTag()
    var tagViewShadowObj = TagViewShadow()
    var tagViewMarginObj = TagViewMargin()
    init() {}
    init(tagTextColor: TagViewTextColor?,
    tagBackgroundColor: TagViewBackGroundColor?,
    tagCornerRadius: TagViewCornerRadius?,
    tagViewPedding: TagViewSetPedding?,
    tagViewRemoveButton: TagViewRemoveTag?,
    tagViewShadow: TagViewShadow?,
    tagViewMargin: TagViewMargin?) {
       if let textColor = tagTextColor { tagViewTextColorObj = textColor }
       if let backGroundColor = tagBackgroundColor { tagViewBackGroundColorObj = backGroundColor }
       if let cornerRadius = tagCornerRadius { tagViewCornerRadiusObj = cornerRadius }
       if let pedding = tagViewPedding { tagViewSetPeddingObj = pedding }
       if let removeButton = tagViewRemoveButton { tagViewRemoveTagObj = removeButton }
       if let shadow = tagViewShadow { tagViewShadowObj = shadow }
       if let margin = tagViewMargin { tagViewMarginObj = margin }
    }
    func setTags(tagView: TagListView, tagsArray: [String]) {
        tagView.addTags(tagsArray)
    }
}
class TagViewTextColor {
    var textColor: UIColor = .black
    var selectedTagTextColor: UIColor = .red
    init() {}
    init(setTextColor: UIColor?, setSelectedTagTextColor: UIColor?) {
        selectedTagTextColor = setSelectedTagTextColor ?? .black
        textColor = setTextColor ?? .red
    }
}
class TagViewBackGroundColor {
    var tagBackgroundColor: UIColor = .groupTableViewBackground
    var selectedTagBackgroundColor: UIColor = .groupTableViewBackground
    var tagHighlightedBackgroundColor: UIColor = .groupTableViewBackground
    init() {}
    init(setTagBackgroundColor: UIColor?,
         setSelectedTagBackgroundColor: UIColor?, setTagHighlightedBackgroundColor: UIColor?) {
        tagBackgroundColor = setTagBackgroundColor ?? .groupTableViewBackground
        selectedTagBackgroundColor = setSelectedTagBackgroundColor ?? .groupTableViewBackground
        tagHighlightedBackgroundColor = setTagHighlightedBackgroundColor ?? .groupTableViewBackground
    }
}
class TagViewCornerRadius {
    var tagViewCornerRadius: CGFloat = 16
    var tagViewBorderWidth: CGFloat = 0
    var tagViewBorderColor: UIColor = .clear
    var selectedTagViewBorderColor: UIColor = .clear
    init() {}
    init(setTagViewCornerRadius: CGFloat?, setTagViewBorderWidth: CGFloat?,
         setTagViewBorderColor: UIColor?, setSelectedTagViewBorderColor: UIColor?) {
        tagViewCornerRadius = setTagViewCornerRadius ?? 0.0
        tagViewBorderWidth = setTagViewBorderWidth ?? 0.0
        tagViewBorderColor = setTagViewBorderColor ?? .clear
        selectedTagViewBorderColor = setSelectedTagViewBorderColor ?? .clear
    }
}
class TagViewSetPedding {
    var peddingX: CGFloat = 12
    var peddingY: CGFloat = 12
    init() {}
    init(xPedding: CGFloat?, yPedding: CGFloat?) {
        peddingX = xPedding ?? 12
        peddingY = yPedding ?? 12
    }
}
class TagViewMargin {
    var marginX: CGFloat = 8
    var marginY: CGFloat = 5
    init() {}
    init(xMargin: CGFloat?, yMargin: CGFloat?) {
        marginX = xMargin ?? 8
        marginY = yMargin ?? 5
    }
}
class TagViewShadow {
    var shadowColor: UIColor = .clear
    var shadowRadius: CGFloat = 0
    var shadowOffset: CGSize = CGSize.zero
    var shadowOpacity: Float = 0
    init() {}
    init(setShadowColor: UIColor?, setShadowRadius: CGFloat,
         setShadowOffset: CGSize, setShadowOpacity: Float) {
    shadowColor = setShadowColor ?? .clear
    shadowRadius = setShadowRadius
    shadowOffset = setShadowOffset
    shadowOpacity = setShadowOpacity
    }
}
class TagViewRemoveTag {
    var removeIconImage: UIImage = #imageLiteral(resourceName: "iconCrossGray")
    var removeButtonEnable: Bool = false
    var removeButtonWidth: CGFloat = 15
    init() {}
    init(setRemoveIconImage: UIImage?, setRemoveButtonEnable: Bool?,
         setRemoveButtonWidth: CGFloat?) {
        removeIconImage = setRemoveIconImage ?? #imageLiteral(resourceName: "iconCrossGray")
        removeButtonEnable = setRemoveButtonEnable ?? false
        removeButtonWidth = setRemoveButtonWidth ?? 15
    }
}
