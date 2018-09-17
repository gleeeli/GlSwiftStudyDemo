//
//  GlTableHeaderView.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2018/9/13.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class GlTableHeaderView: UIView {
    let backImageView = UIImageView.init()
    var imageViewFrame: CGRect!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backImageView.image = UIImage.init(named: "fengjing.jpg")
        backImageView.frame = self.bounds
        backImageView.contentMode = .scaleAspectFill
        self.addSubview(backImageView)

        imageViewFrame = backImageView.frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        var frame = imageViewFrame!
        frame.size.height -= contentOffsetY
        frame.origin.y = contentOffsetY
        backImageView.frame = frame
    }

}
