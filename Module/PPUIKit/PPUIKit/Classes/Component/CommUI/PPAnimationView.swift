//
//  PPAnimationView.swift
//  AdModule
//
//  Created by liguanglei on 2022/10/8.
//

import UIKit
import Lottie

public class PPAnimationView: LOTAnimationView {
    public var playCount  = 1 // 允许播放次数
    public var isRePlayAnimation = false
    private var curPlayCount = 0 // 当前播放次数
    private var isCustomStop = false // 是否手动停止了
    
    public var tapBlock: (()->Void)? {
        didSet {
            if tapBlock != nil {
                setTapGesture()
            }
        }
    }
    
    public func playCustom(complete: (()->Void)?) {
        self.curPlayCount = 0
        self.isCustomStop = false
        
        if self.playCount == 0 {
            complete?()
            return
        }

        self.isRePlayAnimation = true
        self.topPlay {[weak self] in
            guard let self = self else {
                return
            }
            self.isRePlayAnimation = false
            if self.isCustomStop {//已经中途手动停止
                return
            }
            complete?()
        }
    }
    
    public func destory() {
        self.stopCustom()
    }
    
    /// 停止动画
    public func stopCustom() {
        self.stop()
        self.curPlayCount = self.playCount
        self.isCustomStop = true
    }
    
    public func setTapGesture() {
        self.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        self.addGestureRecognizer(tapGes)
    }
    
    @objc func tapClick() {
        self.tapBlock?()
    }

    private func topPlay(complete: (()->Void)?) {
        self.play {[weak self] _ in
            guard let self = self else {
                return
            }
            self.curPlayCount += 1
            if self.playCount > self.curPlayCount {
                print("当前播放:\(self.curPlayCount)")
                self.topPlay(complete: complete)
            } else {
                print("当前播放完成:\(self.curPlayCount)")
                complete?()
            }
        }
    }
}
