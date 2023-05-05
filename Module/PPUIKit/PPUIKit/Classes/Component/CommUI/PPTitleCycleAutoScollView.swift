//
//  PPTitleCycleAutoScollView.swift
//  PPUIKit
//
//  Created by liguanglei on 2023/3/7.
//

import UIKit
import YYText

/*
 从下向上滚动，不断轮播
 */
public protocol PPCycleTitleProtocol {
    var name: String {get}
}

//public class PPModel: PPCycleTitleProtocol {
//    public var name: String = ""
//}

public class PPTitleCycleAutoScollView: UIView {
    public var cellSpace: CGFloat = 31 // 两个cell 之间的上下间距
    public var moveSpace: CGFloat = 0.4
    public var font: UIFont = UIFont.peiPei.aliFontBold(ofSize: 20)
    public var clickTitleBlock: ((_ model: PPCycleTitleProtocol)->())?
    
    private var displayLink: CADisplayLink?
    private var allCells: [PPTitleCycleLabel] = []
    private var runCells: [PPTitleCycleLabel] = []
    private(set) var titles:[PPCycleTitleProtocol] = []
    // 只能设置左右，上下的无效
    private var contentEdgeInset = UIEdgeInsets.zero
    
//    private var minFrame = CGRect.zero
    
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
//        self.minFrame = frame
        setUI()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        refreshGradient()
    }
    
    public func startPlay() {
        if self.displayLink == nil {
            let link = CADisplayLink(target: self, selector: #selector(refreshAllViewAction))
            link.preferredFramesPerSecond = 60
            link.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
            self.displayLink = link
        }
        
    }
    public func isPlaying() -> Bool {
        if self.displayLink != nil {
            return true
        }
        return false
    }
    
    public func stopPlay() {
        self.displayLink?.invalidate()
        self.displayLink = nil
    }
    
    func setUI() {
//        for index in 0..<10 {
//            let model = PPModel()
//            model.name = "说说这张照片的故事吧:\(index)"
//            self.titles.append(model)
//        }
    }
    
    public func setModels(models: [PPCycleTitleProtocol]) {
        self.titles.removeAll()
        self.titles.append(contentsOf: models)
        self.resetAllCells()
    }
    
    public func setContentEdge(left: CGFloat, right: CGFloat) {
        self.contentEdgeInset.left = left
        self.contentEdgeInset.right = right
    }
    
    func resetAllCells() {
        self.allCells.removeAll()
        self.removeAllSubviews()
        
        for (index, model) in self.titles.enumerated() {
            let attr = NSAttributedString.getNormalAttribute(content: model.name, font: self.font, textColor: UIColor.white)
            
            let titleLab = PPTitleCycleLabel()
            titleLab.vid = index
            titleLab.text = model.name
            titleLab.numberOfLines = 0
            //titleLab.attributedText = attr
            titleLab.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapTitleClick))
            titleLab.addGestureRecognizer(tapGes)
            let boundSize = self.getContentMaxSize()
            
            let layout = YYTextLayout(containerSize: boundSize, text: attr)
            let layoutSize: CGSize = layout?.textBoundingSize ?? CGSize.zero
            let lines = layout?.lines.count ?? 0
            titleLab.textLayout = layout
            
            print("行数：\(lines),\(layoutSize.height)")
            titleLab.frame = CGRect(x: self.contentEdgeInset.left, y: boundSize.height, width: layoutSize.width, height: layoutSize.height)
            
            self.allCells.append(titleLab)
        }
    }
    
    func getContentMaxSize() -> CGSize {
        var boundSize = self.bounds.size
//        if boundSize.width <= 0 || boundSize.height <= 0 {
//            boundSize = self.minFrame.size
//        }
        boundSize.width = boundSize.width - self.contentEdgeInset.left - self.contentEdgeInset.right
        boundSize.height = boundSize.height - self.contentEdgeInset.top - self.contentEdgeInset.bottom
        
        return boundSize
    }
    
    func getRandomX(textSize: CGSize, name: String) -> CGFloat {
        let boundSize = self.getContentMaxSize()
        
        var maX = boundSize.width - textSize.width
        let minX = self.contentEdgeInset.left
        if maX < minX {
            maX = minX
        }
        let startX: CGFloat = Double.random(in: minX...maX)
        //print("max:\(maX),nowx:\(startX),textW:\(textSize.width),text:\(name)")
        return startX
    }
    
    @objc func refreshAllViewAction() {
        let boundSize = self.getContentMaxSize()
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
            let haveMoved = boundSize.height - frame.maxY
            //print("haveMoved:\(haveMoved),\(frame.maxY),\(boundSize.height)")
            if haveMoved > cellSpace  {
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
            frame.origin.y = self.getContentMaxSize().height
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
    
    @objc func tapTitleClick(ges: UITapGestureRecognizer) {
        if let label = ges.view as? PPTitleCycleLabel, label.vid < self.titles.count {
            let model = self.titles[label.vid]
            self.clickTitleBlock?(model)
        }
        
    }
}


class PPTitleCycleLabel: YYLabel {
    var vid = -1
}

