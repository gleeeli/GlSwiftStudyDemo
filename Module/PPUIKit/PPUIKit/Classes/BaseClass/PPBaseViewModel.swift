//
//  PPBaseViewModel.swift
//  LoginModule
//
//  Created by 他趣 on 2022/3/18.
//

import Foundation
import RxSwift
import RxCocoa

public protocol PPBaseViewModelProperty {
    var disposeBag: DisposeBag {get}
    init()
}

open class PPBaseViewModel: NSObject, PPBaseViewModelProperty {
    public lazy var disposeBag = DisposeBag()
    public var isShowLoading = false {
        didSet {
            loadingObservable.onNext(isShowLoading)
//            self.rx.isShowLoading.asControlEvent()
        }
    }

    public var isShowEmpty = false {
        didSet {
            emptyObservable.onNext(isShowEmpty)
        }
    }

    public lazy var loadingObservable = RxSwift.PublishSubject<Bool>.init()
    public lazy var emptyObservable = RxSwift.PublishSubject<Bool>.init()

    required public override init() {

    }

    open func loadData() {

    }

    @objc dynamic public func endRefresh() {

    }

    @objc dynamic public func reloadData() {

    }

}

public extension Reactive where Base: PPBaseViewModel {
    var endRefreshState: ControlEvent<Void> {
        let source = self.sentMessage(#selector(base.endRefresh)).map { _ in
            return
        }
        return ControlEvent.init(events: source)
    }

    var reloadData: ControlEvent<Void> {
        let source = self.sentMessage(#selector(base.reloadData)).map { _ in
            return
        }
        return ControlEvent.init(events: source)
    }
//
//    var isShowEmpty: ControlEvent<Bool>{
//        let source = self.sentMessage(#selector(base.endRefresh)).map { l in
//            return
//        }
//        return ControlEvent.init(events: source)
//    }
//    var isShowLoading: ControlEvent<Bool>{
////        let
//        return controlEvent(<#T##UIControl.Event#>)
//    }
}
