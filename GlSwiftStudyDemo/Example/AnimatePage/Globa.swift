//
//  Globa.swift
//  ZXFCardsTurnArround
//
//  Created by 赵希帆 on 16/6/1.
//  Copyright © 2016年 赵希帆. All rights reserved.
//

import UIKit

protocol CardCountDelegate {
    func CardCountReduce(cardview : ZXFCardView)->Void
}

class Gloab: NSObject {
    
    static var Screen_Width : CGFloat = UIScreen.main.bounds.size.width
    
     static var Screen_Height : CGFloat = UIScreen.main.bounds.size.height
    
    
}
