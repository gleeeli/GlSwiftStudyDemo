//
//  TitleCycleScrollViewViewController.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/3/6.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import UIKit
import SwiftUI
import YYText

class TitleCycleScrollViewViewController: UIViewController {

    let titleCycleView = PPTitleCycleAutoScollView(frame: CGRect(x: 0, y: 160, width: UIScreen.main.bounds.width, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(titleCycleView)
        titleCycleView.startPlay()
    }

}

protocol PPCycleTitleProtocol {
    var name: String {get}
}

class PPModel: PPCycleTitleProtocol {
    var name: String = ""
}

class PPTitleCycleAutoScollView: UIView {
    lazy var displayLink = {
        let link = CADisplayLink(target: self, selector: #selector(refreshAllViewAction))
        link.preferredFramesPerSecond = 60
        return link
    }()
    var allCells: [PPTitleCycleLabel] = []
    var runCells: [PPTitleCycleLabel] = []
    
    var titles:[PPCycleTitleProtocol] = []
    var cellSpace: CGFloat = 31 // 两个cell 之间的上下间距
    var moveSpace: CGFloat = 0.4
    
    lazy var topBottomGradient: CAGradientLayer =  {
        let topBottomGradient = CAGradientLayer()
        topBottomGradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        topBottomGradient.endPoint = CGPoint(x: 0.5, y: 1)

        let whiteColor = UIColor.white
        topBottomGradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor, whiteColor.withAlphaComponent(1.0).cgColor,
                           whiteColor.withAlphaComponent(1.0).cgColor, whiteColor.withAlphaComponent(0.0).cgColor]

        topBottomGradient.locations = [NSNumber(value: 0.0),NSNumber(value: 0.35),NSNumber(value: 0.65),NSNumber(value: 1)]
        return topBottomGradient
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startPlay() {
        self.displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
//        self.displayLink.add(to: RunLoop.current, forMode: .com)
    }
    
    func setUI() {
        for index in 0..<10 {
            let model = PPModel()
            model.name = "说说这张照片的故事吧说说这张照片的故事吧说说这张照片的故事吧说说这张照片的故事吧说说这张照片的故事吧:\(index)张照片的故事吧张照片的故事吧张照片的故事吧123456"
            self.titles.append(model)
        }
        
        for (index, model) in self.titles.enumerated() {
            let font = UIFont.systemFont(ofSize: 12)
            let attr = NSAttributedString.getNormalAttribute(content: model.name, font: font, textColor: UIColor.white)
            
            let titleLab = PPTitleCycleLabel()
            titleLab.vid = index
            titleLab.text = model.name
            titleLab.numberOfLines = 0
            titleLab.font = font
            titleLab.attributedText = attr
            
            let boundSize = self.bounds.size
            let textContainer = YYTextContainer(size: CGSize(width: 393, height: CGFloat(MAXFLOAT)))
            textContainer.maximumNumberOfRows = 3// nowLines
            //textContainer.truncationType = .end
            //textContainer.truncationToken = label.getNowTruncationToken()
            
            let layout = YYTextLayout(containerSize: CGSize(width: 393, height: CGFloat(MAXFLOAT)), text: attr)
            let layoutSize: CGSize = layout?.textBoundingSize ?? CGSize.zero
            let lines = layout?.lines.count ?? 0
            print("文字高度:\(layoutSize.height),lines:\(lines)")
            
            let layout2 = YYTextLayout(container: textContainer, text: attr)
            let layoutSize2: CGSize = layout2?.textBoundingSize ?? CGSize.zero
            
            print("文字高度2:\(layoutSize2.height)")
            titleLab.frame = CGRect(x: 0, y: boundSize.height, width: layoutSize.width, height: CGFloat(lines * 16))
            
            self.allCells.append(titleLab)
        }
        
        refreshGradient()
    }
    
    func getRandomX(textSize: CGSize, name: String) -> CGFloat {
        let boundSize = self.bounds.size
        
        let maX = boundSize.width - textSize.width
        let startX: CGFloat = Double.random(in: 0...maX)
        //print("max:\(maX),nowx:\(startX),textW:\(textSize.width),text:\(name)")
        return startX
    }
    
    @objc func refreshAllViewAction() {
        let boundSize = self.bounds.size
        //print(boundSize)
        var waitRemoves: [Int] = []
        
        for label in self.runCells {
            var frame = label.frame
            if frame.maxY < 0 {
                frame.origin.y = boundSize.height
                label.removeFromSuperview()
                //print("移除：\(label.vid)")
                waitRemoves.append(label.vid)
            }else {
                frame.origin.y = frame.origin.y - moveSpace
            }
            label.frame = frame
        }
        
        self.removeViewFromCells(waitRemovesIds: waitRemoves)
        
        if self.runCells.count > 0, let lastCell = self.runCells.last {
            let frame = lastCell.frame
            
            if (boundSize.height - frame.maxY) > cellSpace  {
                var nextIndex = lastCell.vid + 1
                if nextIndex >= self.allCells.count {
                    nextIndex = 0
                }
                let nextLabel = self.allCells[nextIndex]
                self.appendLabelFromBottom(label: nextLabel)
            }
            
        }else if self.allCells.count > 0, let firstCell = self.allCells.first {// 还没有添加label上去
            
            self.appendLabelFromBottom(label: firstCell)
        }
    }
    
    func refreshGradient() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.topBottomGradient.frame = self.bounds
        self.layer.mask = topBottomGradient
                
        CATransaction.commit()
    }
    
    /// 从底部追加label
    func appendLabelFromBottom(label: PPTitleCycleLabel) {
        if label.superview == nil {
            self.addSubview(label)
            var frame = label.frame
            let startX: CGFloat = getRandomX(textSize: frame.size, name: label.text ?? "")
            
            frame.origin.x = startX
            label.frame = frame
            self.runCells.append(label)
        }
        
    }
    
    func removeViewFromCells(waitRemovesIds: [Int]) {
        for vid in waitRemovesIds {
            let findIndex = getIndexWith(viewId: vid)
            if findIndex >= 0 && findIndex < self.runCells.count {
                self.runCells.remove(at: findIndex)
            }
        }
    }
    
    func getIndexWith(viewId: Int) -> Int {
        for (index , value) in self.runCells.enumerated() {
            if value.vid == viewId {
                return index
            }
        }
        return -1
    }
}


class PPTitleCycleLabel: UILabel {
    var vid = -1
    // 父视图的frame
    var fatherFrame = CGRect.zero
    
    override var frame: CGRect {
        didSet {
            framechange()
        }
    }
    
    func framechange() {
        
    }
}
