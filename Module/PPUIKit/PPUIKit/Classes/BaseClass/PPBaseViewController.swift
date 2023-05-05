//
//  PPBaseViewController.swift
//  LoginModule
//
//  Created by 他趣 on 2022/3/18.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa
import Then
import XHBFrame
import PPBaseModule

public protocol PPBaseViewControllerPeoperty {
    associatedtype U
    var viewModel: U {get set}
}

public enum PPRefreshType {
    case header
    case footer
    case all
}

public protocol PPRefreshProtocol: AnyObject {

    var refreshType: PPRefreshType? {get set}

    // 上拉更多
    func loadMore()

    // 下拉刷新
    func loadNew()
}

open class PPBaseViewController<T: PPBaseViewModel>: HBViewController, PPBaseViewControllerPeoperty, PPRefreshProtocol {

    public typealias viewModelType = T
    public typealias U = viewModelType
    public lazy var viewModel = viewModelType.init()

    // 控制rx销毁
    public lazy var disposeBag = DisposeBag()

    //
    public var observable: Observable<Element>?

    // 右边navigationItem按钮
    public lazy var rightItemOnClick: PublishSubject<UIView> = PublishSubject.init()

    public lazy var tableView: UITableView = UITableView.init(frame: .zero, style: tableViewStyle()).then {[weak self] in
        $0.separatorStyle = .none
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        $0.sectionFooterHeight = 0.1
        $0.sectionHeaderHeight = 0.1
        $0.estimatedSectionHeaderHeight = 0.1
        $0.estimatedSectionFooterHeight = 0.1
        $0.contentInsetAdjustmentBehavior = .never
        $0.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 0.1))
        $0.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 0.1))
    }

    public var refreshType: PPRefreshType? {
        didSet {
            if let r = refreshType {
                let footer = XHBRefreshFooter.init {[weak self] in
                    guard let strongSelf = self else {return}
                    strongSelf.loadMore()
                }

                let header = XHBRefreshHeader.init {[weak self] in
                    guard let strongSelf = self else {return}
                    strongSelf.loadNew()
                }
                switch r {
                case .header:
                    tableView.mj_footer = footer
                    break
                case .footer:
                    tableView.mj_header = header
                    break
                case .all:
                    tableView.mj_header = header
                    tableView.mj_footer = footer
                    break
                }
            } else {
                tableView.mj_header = nil
                tableView.mj_footer = nil
            }
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        if let image = navigationBarImageTitle() {
            let imageView = UIImageView(image: image)
            self.navigationItem.titleView = imageView
        }
        view.backgroundColor = PPUIColor.themeDark2Color
        self.viewModel.loadingObservable.subscribe {[weak self] loading in
            self?.showLoading(loading)
        }.disposed(by: disposeBag)

        viewModel.rx.endRefreshState.subscribe(onNext: {[weak self] in
            self?.endTableViewRefresh()
        }).disposed(by: disposeBag)

        self.viewModel.emptyObservable.subscribe(onNext: { [weak self] showEmpty in
            self?.willShowEmpty(showEmpty)
            self?.showEmpty(showEmpty)
        }).disposed(by: disposeBag)

        viewModel.rx.reloadData.subscribe(onNext: {[weak self] in
            self?.tableView.reloadData()
        }).disposed(by: viewModel.disposeBag)

        _setupNav()
        setupUI()
        loadData()
        bindViewModel()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNavigationBarTransparent() {
            edgesForExtendedLayout = [.left, .right, .top]
            navigationController?.navigationBar.tintColor = .clear
            navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage.init()

            if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor =    .clear
                appearance.shadowColor = .clear
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
            }

        }
        
        self.setIos11PhoneNavigation()
    }

    // 数据初始化
    open func configureData() {

    }

    // 视图初始化
    open func setupUI() {

    }

    // 数据加载
    open func loadData() {

    }

    // 绑定
    open func bindViewModel() {

    }

    // ============配置导航栏右边按钮
    open func configureRightItems() -> [UIImage] {
        return []
    }

    // ==============tableview相关上下拉
    // 上拉更多
    open func loadMore() {

    }

    // 下拉刷新
    open func loadNew() {

    }

    open func tableViewStyle()->UITableView.Style {
        return .plain
    }

    // =========导航条==============
    // 是否透明
    open func isNavigationBarTransparent() -> Bool {
        return false
    }

    open func navigationBarImageTitle() -> UIImage? {
        return nil
    }

    // =========内容为空=============
    open override func getEmptyView() {
        self.emptyView.setImage(getImageOfEmptyView(), labelText: getTitleOfEmptyView(), subLabelText: getSubTitleOfEmptyView())
        self.emptyView.label.font = UIFont.peiPei.aliFontMedium(ofSize: 17)
        self.emptyView.subLabel.font  = UIFont.peiPei.aliFontMedium(ofSize: 14)
    }

    open func getSubTitleOfEmptyView() -> String {
        return ""
    }

    open func getTitleOfEmptyView() -> String {
        return "空空如也"
    }

    open func getImageOfEmptyView() -> UIImage {
        return UIImage.pp_imageNamed("mc_friend_empty")

//    open func getImageOfEmptyView() -> UIImage {
//        return .peiPei.mc_friend_empty

    }

    open func willShowEmpty(_ showEmpty: Bool) {

    }

    open func reloadNav() {
        _setupNav()
    }
}

public extension PPBaseViewController {
    func configureViewModels(_ array: [PPBaseViewModel]) {
        array.forEach { model in
            model.loadingObservable.subscribe {[weak self] loading in
                self?.showLoading(loading)
            }.disposed(by: disposeBag)
        }
    }
}

public extension PPBaseViewController {
    /**
    渐变显示队列
     */
    func joinAnimationQueue(_ views: [UIView], completion: (() -> Void)?) {
        for item in views {
            item.alpha = 0
        }
        animation(views, index: 0, completion: completion)
    }
    private func animation(_ views: [UIView], index: Int, completion: (() -> Void)?) {
        if index < views.count {
            let item = views[index]
            UIView.animate(withDuration: 0.5) {
                item.alpha = 1
            } completion: { _ in
                self.animation(views, index: index+1, completion: completion)
            }
        } else {
            completion?()
        }
    }
}

private extension PPBaseViewController {
    func _setupNav() {
        let items = configureRightItems()
        if items.count <= 0 {
            navigationItem.rightBarButtonItem = nil
            return
        }

        var navItems: [UIBarButtonItem] = []

        for item in items {
            let btn = UIButton.init(type: .custom)
            btn.setImage(item, for: .normal)
            btn.rx.tap.subscribe {[weak self, weak btn] _ in
                guard let strongSelf = self else {return}
                guard let btnSelf = btn else {return}
                strongSelf.rightItemOnClick.onNext(btnSelf)
            }.disposed(by: disposeBag)
            navItems.append(UIBarButtonItem.init(customView: btn))
        }
        navigationItem.rightBarButtonItems = navItems
    }

    func endTableViewRefresh() {
        tableView.mj_footer?.endRefreshing()
        tableView.mj_header?.endRefreshing()
    }
}
