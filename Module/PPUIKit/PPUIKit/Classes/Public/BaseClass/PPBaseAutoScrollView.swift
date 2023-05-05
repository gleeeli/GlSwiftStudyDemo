//
//  PPBaseScrollView.swift
//  PPUIKit
//
//  Created by liguanglei on 2022/8/1.
//

import UIKit

public enum PPBaseAutoScrollViewType {
    case horizontal
    case vertical
}

/* 内容用用约束布局，自动滚动
    内容必须加在contentView，上下滚动时：顶部和底部必须有约束
 */
public class PPBaseAutoScrollView: UIScrollView {
    public var contentView = UIView()
    public var scrollType: PPBaseAutoScrollViewType = .horizontal {
        didSet {
            changeScrollType()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.addSubview(self.contentView)
        self.scrollType = .horizontal
    }

    func changeScrollType() {
        if self.scrollType == .horizontal {
            self.contentView.snp.remakeConstraints { make in

                make.edges.equalToSuperview()
                make.centerY.equalTo(self)
            }
        } else {
            self.contentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
                make.centerX.equalTo(self)
            }
        }
    }
}
