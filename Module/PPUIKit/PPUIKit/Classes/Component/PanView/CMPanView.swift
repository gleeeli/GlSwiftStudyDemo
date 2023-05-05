//
//  CMPanView.swift
//  ConfigModule
//
//  Created by 林庆霖 on 2022/4/24.
//

import UIKit
import RxSwift

public class CMPanView: UIView {

    @objc public var target: UIView?
    @objc public var area: PanActionArea = .bar
    @objc public var barStyle: PanBarStyle = .light {
        didSet {
//            let imageName = barStyle == .light ? "icon_close_line" : "icon_close_line_dark"
//            panBar.image = .pp_imageNamed(imageName)
            panBar.backgroundColor = barStyle == .light ? UIColor(hexString: "3A3B40") : UIColor(hexString: "3A3B40")
        }
    }

    @objc public var minOffset: (() -> CGFloat)?
    @objc public var maxOffset: (() -> CGFloat)?
    @objc public var finishedAtOffset: ((CGFloat) -> Void)?

    private var originGestureCenter: CGPoint?
    private var originSuperviewCenter: CGPoint?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(panGesture)
        addSubview(panBar)
        panBar.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 64, height: 6))
        }
        panBar.layer.cornerRadius = 3
        panBar.layer.masksToBounds = true
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        removeGesture()
        if let target = target,
           target != self {
            target.addGestureRecognizer(panGesture)
            return
        } else if area == .all {
            superview?.addGestureRecognizer(panGesture)
        } else {
            addGestureRecognizer(panGesture)
            panBar.isHidden = false
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let disposeBag = DisposeBag()

    private lazy var panBar: UIView = UIView()

// =======
//
//    private lazy var panBar: UIImageView = UIImageView(image: .peiPei.icon_close_line)
//
// >>>>>>> feature/2022_06_1qi
    lazy var panGesture = UIPanGestureRecognizer().then {
        $0.rx.event.bind { [weak self] gesture in
            guard let self = self else {
                return
            }
            guard let superview = self.superview else {
                return
            }
            guard let ultraview = superview.superview else {
                return
            }

            var ultraCenter = gesture.location(in: ultraview)
            var center = gesture.location(in: superview)

            switch gesture.state {
            case .began:
                self.originGestureCenter = ultraCenter
                self.originSuperviewCenter = superview.center
            case .changed:
                guard let originGestureCenter = self.originGestureCenter else {
                    return
                }
                guard let originSuperviewCenter = self.originSuperviewCenter else {
                    return
                }
                let offset = ultraCenter.y - originGestureCenter.y

                if let minOffset = self.minOffset,
                   offset < minOffset() {
                    superview.center.y = originSuperviewCenter.y + minOffset()
                    return
                }
                if let maxOffset = self.maxOffset,
                   offset > maxOffset() {
                    superview.center.y = originSuperviewCenter.y + maxOffset()
                    return
                }
                superview.center.y = originSuperviewCenter.y + offset
            case .cancelled:
                fallthrough
            case .ended:
                if let finishedAtOffset = self.finishedAtOffset,
                   let originSuperviewCenter = self.originSuperviewCenter {
                    let offset = superview.center.y - originSuperviewCenter.y
                    finishedAtOffset(offset)
                }
            default:
                break
            }
        }.disposed(by: disposeBag)
    }

    private func removeGesture() {
        removeGestureRecognizer(panGesture)
        superview?.removeGestureRecognizer(panGesture)
        target?.removeGestureRecognizer(panGesture)
        panBar.isHidden = true
        panBar.backgroundColor = UIColor(hexString: "3A3B40")
    }
}
