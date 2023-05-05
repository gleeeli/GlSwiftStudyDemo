//
//  CMActionSheet.swift
//  TestModule
//
//  Created by 林庆霖 on 2022/4/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
// import ConfigModule

/**
 @example:
 CMActionSheet(title: "确定删除建议吗？", texts: ["1", "2", "3", "删除"]) { view, index in
     return CMActionSheetCell.self
 } heightForIndex: { view, index in
     return CMActionSheet.automaticHeight
 } didSelectedAtIndex: { view, index, item in
     print(index, item)
 }.show()
 
 @param title: 标题
 @param texts: 选项文本
 @param cellForIndex: 自定义选项视图 可为空
 @param heightForIndex: 自定义选项高度 自适应高度使用CMActionSheet.automaticHeight 可为空
 @param didSelectedAtIndex: 响应点击选项 可为空
 
 convenience init(title: String? = nil,
            attributeTexts: [NSAttributedString],
            cellForIndex: ((CMActionSheet, Int) -> CMActionSheetCell.Type)? = nil,
            heightForIndex: ((CMActionSheet, Int) -> CGFloat)? = nil,
            didSelectedAtIndex: ((CMActionSheet, Int, CMActionSheetItem) -> Void)? = nil)
 @param attributeTexts: 设置属性字符串
 
 convenience init(title: String? = nil,
            items: [CMActionSheetItem] = [],
            cellForIndex: ((CMActionSheet, Int) -> CMActionSheetCell.Type)? = nil,
            heightForIndex: ((CMActionSheet, Int) -> CGFloat)? = nil,
            didSelectedAtIndex: ((CMActionSheet, Int, CMActionSheetItem) -> Void)? = nil)
 @param items 数据源
 自定义数据源 可继承CMActionSheetItem
 自定义选项 可继承CMActionSheetCell
 
 @mark 代理优先级高于闭包
 */

@objc  public class CMActionSheetItem: NSObject {
    @objc public var text: String?
    @objc public var attributeText: NSAttributedString?
}

protocol CMActionSheetDataSource: AnyObject {
    func actionSheet(_ actionSheet: PPCMActionSheet, cellForIndex: Int) -> CMActionSheetCell.Type
    func actionSheet(_ actionSheet: PPCMActionSheet, heightForIndex: Int) -> CGFloat
    func actionSheet(_ actionSheet: PPCMActionSheet, didSelectedAt index: Int, with item: CMActionSheetItem)
}

extension CMActionSheetDataSource {
    func actionSheet(_ actionSheet: PPCMActionSheet, cellForIndex: Int) -> CMActionSheetCell.Type {
        return CMActionSheetCell.self
    }

    func actionSheet(_ actionSheet: PPCMActionSheet, heightForIndex: Int) -> CGFloat {
        return PPCMActionSheet.defaultActionSheetHeight
    }

    func actionSheet(_ actionSheet: PPCMActionSheet, didSelectedAt index: Int, with item: CMActionSheetItem) {

    }
}

public  class PPCMActionSheet: PPCMPanAlertView {
    fileprivate static let defaultActionSheetHeight: CGFloat = 56

    var showPanView: Bool = true
    var showSeparatorLine: Bool = true
    var showCancelButton: Bool = true

    weak var dataSource: CMActionSheetDataSource?

    private var items: [CMActionSheetItem] = []
    private var title: String?

    private var cellForIndexClosure: ((PPCMActionSheet, Int) -> CMActionSheetCell.Type)?
    private var heightForIndexClosure: ((PPCMActionSheet, Int) -> CGFloat)?
    private var didSelectedAtIndexClosure: ((PPCMActionSheet, Int, CMActionSheetItem) -> Void)?

   @objc public  convenience init(title: String? = nil,
                     texts: [String],
                     cellForIndex: ((PPCMActionSheet, Int) -> CMActionSheetCell.Type)? = nil,
                     heightForIndex: ((PPCMActionSheet, Int) -> CGFloat)? = nil,
                     didSelectedAtIndex: ((PPCMActionSheet, Int, CMActionSheetItem) -> Void)? = nil) {
        self.init(frame: .zero)
        var items: [CMActionSheetItem] = []
        for text in texts {
            let item = CMActionSheetItem()
            item.text = text
            items.append(item)
        }
        self.title = title
        self.items = items
        self.cellForIndexClosure = cellForIndex
        self.heightForIndexClosure = heightForIndex
        self.didSelectedAtIndexClosure = didSelectedAtIndex
    }

    @objc public convenience init(title: String? = nil,
                     attributeTexts: [NSAttributedString],
                     cellForIndex: ((PPCMActionSheet, Int) -> CMActionSheetCell.Type)? = nil,
                     heightForIndex: ((PPCMActionSheet, Int) -> CGFloat)? = nil,
                     didSelectedAtIndex: ((PPCMActionSheet, Int, CMActionSheetItem) -> Void)? = nil) {
        self.init(frame: .zero)
        var items: [CMActionSheetItem] = []
        for attributeText in attributeTexts {
            let item = CMActionSheetItem()
            item.attributeText = attributeText
            items.append(item)
        }
        self.title = title
        self.items = items
        self.cellForIndexClosure = cellForIndex
        self.heightForIndexClosure = heightForIndex
        self.didSelectedAtIndexClosure = didSelectedAtIndex
    }

    convenience init(title: String? = nil,
                     items: [CMActionSheetItem] = [],
                     cellForIndex: ((PPCMActionSheet, Int) -> CMActionSheetCell.Type)? = nil,
                     heightForIndex: ((PPCMActionSheet, Int) -> CGFloat)? = nil,
                     didSelectedAtIndex: ((PPCMActionSheet, Int, CMActionSheetItem) -> Void)? = nil) {
        self.init(frame: .zero)
        self.title = title
        self.items = items
        self.cellForIndexClosure = cellForIndex
        self.heightForIndexClosure = heightForIndex
        self.didSelectedAtIndexClosure = didSelectedAtIndex
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
        contentHeight = PPCMPanAlertView.automaticHeight
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func constructView() {
        super.constructView()
        var latestView: UIView?
        if let title = title,
           !title.isEmpty {
            titleLabel.text = title
            contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.top.left.equalTo(16)
                make.right.equalTo(-16)
            }
            latestView = titleLabel
        }
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            if let latestView = latestView {
                make.top.equalTo(latestView.snp.bottom).offset(16)
            } else {
                make.top.equalToSuperview()
            }
            if !showCancelButton {
                make.bottom.equalToSuperview()
            }
        }

        if showCancelButton {
            contentView.addSubview(cancelSeparatorLine)
            contentView.addSubview(cancelButton)
            cancelSeparatorLine.snp.makeConstraints { make in
                make.top.equalTo(stackView.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(8)
            }
            cancelButton.snp.makeConstraints { make in
                make.top.equalTo(cancelSeparatorLine.snp.bottom)
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(56)
            }
        }

        constructCell()

        setNeedsLayout()
        layoutIfNeeded()
    }

    private func constructCell() {
        for subview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        for (idx, item) in items.enumerated() {
            var cls: CMActionSheetCell.Type
            if let dataSource = dataSource {
                cls = dataSource.actionSheet(self, cellForIndex: idx)
            } else if let cellForIndexClosure = cellForIndexClosure {
                cls = cellForIndexClosure(self, idx)
            } else {
                cls = CMActionSheetCell.self
            }

            let cell = cls.init()
            cell.index = idx
            cell.item = item
            cell.showSeparatorLine = showSeparatorLine
            cell.rx.controlEvent(.touchUpInside).bind { [weak self] in
                guard let self = self else {
                    return
                }
                self.dataSource?.actionSheet(self, didSelectedAt: idx, with: item)
                if let didSelectedAtIndexClosure = self.didSelectedAtIndexClosure {
                    didSelectedAtIndexClosure(self, idx, item)
                }
                self.dismiss()
            }.disposed(by: disposeBag)

            stackView.addArrangedSubview(cell)
            cell.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                if let height = dataSource?.actionSheet(self, heightForIndex: idx) {
                    if height != PPCMActionSheet.automaticHeight { // 按给定的高度设置，设置了自适应则不设置高度
                        make.height.equalTo(height)
                    }
                } else if let heightForIndexClosure = heightForIndexClosure {
                    let height = heightForIndexClosure(self, idx)
                    if height != PPCMActionSheet.automaticHeight { // 按给定的高度设置，设置了自适应则不设置高度
                        make.height.equalTo(height)
                    }
                } else { // 没实现代理，设置默认高度
                    make.height.equalTo(PPCMActionSheet.defaultActionSheetHeight)
                }
            }
        }
    }

    private lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()

    public lazy var titleLabel: UILabel = UILabel().then {
        $0.textColor = PPUIColor.textStressBlackColor
        $0.font = UIFont.peiPei.aliFontMedium(ofSize: 17)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    private lazy var cancelSeparatorLine: UIView = UIView().then {
        $0.backgroundColor = PPUIColor.bg4LightGrayColor
    }

    private lazy var cancelButton: UIButton = UIButton(type: .custom).then {
        $0.titleLabel?.font = .peiPei.aliFontMedium(ofSize: 17)
        $0.setTitle("取消", for: .normal)
        $0.setTitleColor(PPUIColor.textWeakenBlackAlpha036Color, for: .normal)
        $0.rx.tap.subscribe { [weak self] _ in
            self?.dismiss()
        }.disposed(by: disposeBag)
    }
}

public class CMActionSheetCell: UIControl {
    public var showSeparatorLine: Bool = true {
        didSet {
            if showSeparatorLine {
                addSubview(separatorLine)
                separatorLine.snp.makeConstraints { make in
                    make.bottom.left.right.equalToSuperview()
                    make.height.equalTo(0.5)
                }
            } else {
                separatorLine.removeFromSuperview()
            }
        }
    }
    public var index: Int = 0
    public var item: CMActionSheetItem? {
        didSet {
            constructView()
        }
    }

    public func constructView() {
        guard let item = item else {
            return
        }
        if let attributeText = item.attributeText,
           attributeText.length > 0 {
            textLabel.attributedText = attributeText
            addSubview(textLabel)
            textLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        } else if let text = item.text,
           !text.isEmpty {
            textLabel.text = text
            addSubview(textLabel)
            textLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }

    public lazy var separatorLine = UIView().then {
        $0.backgroundColor = PPUIColor.lineNormalBlackAlpha005Color
    }

    public lazy var textLabel = UILabel().then {
        $0.textColor = PPUIColor.themeP0Color
        $0.font = .peiPei.aliFontMedium(ofSize: 17)
    }
}
