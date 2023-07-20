//
//  PPCustomButton.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/30.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import UIKit

class PPCustomButton: UIButton {

    var isUserLayout = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.isUserLayout,let titleSize = self.titleLabel?.intrinsicContentSize, let iconSize = self.currentImage?.size {
            var titleOffset = (self.bounds.size.width - titleSize.width) / 2
//            titleOffsets = iconSize.width
            //其中包含的四个参数意义为：元素某个边界距离控件某个边界的距离，正值为靠近控件矩形区域的中心，负值为远离控件矩形区域的中心。
            UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let iconOffset = (self.bounds.size.width - iconSize.width) / 2
            self.imageEdgeInsets = UIEdgeInsets(top: -iconSize.height, left: iconOffset, bottom: 0, right: -iconOffset)
            
            self.titleEdgeInsets = UIEdgeInsets(top: titleSize.height, left: -titleOffset, bottom: 0, right: titleOffset)
            
            print("img:\(self.imageEdgeInsets)")
            print("title:\(self.titleEdgeInsets)")
        }
    }

}
