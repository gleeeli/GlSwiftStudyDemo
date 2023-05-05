//
//  PPAlertPopManager.swift
//  DemoSwiftModule
//
//  Created by WJK on 2022/10/12.
//

import UIKit

/// 同一级别顺序按照顺序弹窗
/// 不同级别,先弹优先级高的 (1 最高)
/// 有展示第级别弹窗,添加高级别弹窗- 低级别先删除掉,弹高级别,- 再谈刚才弹窗.

 public protocol AlertPopProtocol: UIView {
    var app_level: GradedViewLevel {get set}
    var app_isShow: Bool {get set}
    /// 展示动画
    func app_willBeShow(container: UIView)
    /// 隐藏动画 - 必须回调 completion 否者不会弹后面弹窗
    func app_willBeHidden(completion:@escaping (_ isFinished: Bool) -> Void )
}

@objc public class PPAlertPopManager: NSObject {

    public   static var shareInstance = PPAlertPopManager()
    var semaphore: DispatchSemaphore!
    //    var queue : NSPointerArray!
    var queue: [AlertPopProtocol]! // 对view有强引用

    var currentShowView: AlertPopProtocol?

    private override init() {
        queue = [PPGradedView]()
        semaphore = DispatchSemaphore(value: 1)
    }

    @objc public static func removeAll() {
        PPAlertPopManager.shareInstance.removeAllView()
    }

    static func removeInstanceAndAll() {
        shareInstance.removeAllView()
        shareInstance.queue =  [PPGradedView]()
        shareInstance.semaphore = DispatchSemaphore(value: 1)
    }

}

// MARK: - 队列相关
public extension PPAlertPopManager {

      func addToQueneView(view: AlertPopProtocol?) {
        guard let view = view else { return }
        semaphore.wait()

        if let currentShowViewTmp = currentShowView {
            // 新来弹窗小于 等于 正在展示的  新来弹窗不展示 1 > 5
            if currentShowViewTmp.app_level.rawValue <= view.app_level.rawValue {
                view.isHidden = true
                self.queue.append(view)
                sortQueue()
            } else {
                self.currentShowView?.isHidden = true
                self.queue.insert(view, at: 0)
                self.currentShowView?.removeFromSuperview()
            }
        } else {
            view.isHidden = true
            self.queue.append(view)
            sortQueue()
        }

        if self.queue.count > 1 {
            /// currentShowView已经隐藏 但未
            if  self.currentShowView != nil && self.currentShowView?.window == nil {
                self.removeToQueneView(view: self.currentShowView)
            }else {
                showNextView()
            }
        } else if self.queue.count == 1 {
            showView(view: view)
        }
        semaphore.signal()
    }

    func removeToQueneView(view: AlertPopProtocol?) {
        guard let view = view else { return }
        if let tmpCurrentShowView = self.currentShowView {
            if tmpCurrentShowView == view {
                /// 隐藏动画
                self.currentShowView?.app_willBeHidden(completion: {[weak self] _ in
                    if var _ = self?.queue {
                        self?.queue.removeAll {gradedView in
                            return  view == gradedView
                        }
                    }
                    self?.showNextView()
                })

            } else {
                if var _ = self.queue {
                    self.queue.removeAll {gradedView in
                        return  view == gradedView
                    }
                    view.removeFromSuperview()
                }

            }
        }

    }

}

// MARK: - 展示视图
extension PPAlertPopManager {
    func showView(view: AlertPopProtocol) {
        if  let tmpCurrentShowView = self.currentShowView, view == tmpCurrentShowView {
            return
        }
        if let window = UIApplication.shared.delegate?.window ?? UIWindow() {
            view.isHidden = false
            view.app_willBeShow(container: window) // 调用展示动画
            self.currentShowView = view
        }
    }
}

// MARK: -
extension PPAlertPopManager {
    func removeAllView() {

        if let currentShowViewTmp = self.currentShowView {
            self.queue.removeAll()
            removeToQueneView(view: currentShowViewTmp)
            self.currentShowView = nil
        } else {
            self.queue.map { view in
                view.removeFromSuperview()
            }
            self.queue.removeAll()
        }
    }

    func sortQueue() {
        self.queue = self.queue.sorted { gradedView1, gradedView2 in
            return gradedView1.app_level.rawValue < gradedView2.app_level.rawValue
        }
    }

    /// 展示下一个
    func showNextView() {
        if self.queue.count > 0, let view = self.queue.first {
            showView(view: view)
        } else {
            self.currentShowView = nil
        }
    }
}

// MARK: - 类型转换
extension PPAlertPopManager {

    func bridge<T: AnyObject>(obj: T) -> UnsafeMutableRawPointer {

        return UnsafeMutableRawPointer(Unmanaged.passUnretained(obj).toOpaque())

    }

    func bridgeTransfer<T: AnyObject>(ptr: UnsafeMutableRawPointer) -> T {
        return Unmanaged<T>.fromOpaque(ptr).takeRetainedValue()}
}
