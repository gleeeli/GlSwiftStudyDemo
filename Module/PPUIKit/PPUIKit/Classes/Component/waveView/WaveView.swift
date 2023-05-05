//
//  WaveView.swift
//  LLWave
//
//  Created by liping on 2017/9/5.
/*
 正弦型函数解析式：y = A * sin(ωx+φ) + h
 周期T = 2π/ω
 各常数值对函数图像的影响：
 
 φ（初相位）：决定波形与X轴位置关系或横向移动距离（左加右减）
 
 ω：决定周期（最小正周期T=2π/|ω|）
 
 A：决定峰值（即纵向拉伸压缩的倍数）
 
 h：表示波形在Y轴的位置关系或纵向移动距离（上加下减）
 
 */
import UIKit
import XHBSwiftKit

public class WaveView: UIView {
    /// 移动功能
    public var  haveMove = false

    // 析构函数
    deinit {
        stop()
        debugPrint("WaveView - deinit")
    }

    var  isHaveTime = false

    var viewHeight: CGFloat = 0
    var viewWeight: CGFloat = 0

    lazy var bubbleView: UIView =  {
        let BubbleView = UIView(frame: CGRect(x: 13, y: (1 - rate) * bounds.height + 10, width: 6, height: 6 ))

        self.addSubview(BubbleView)
        BubbleView.backgroundColor = color1
        BubbleView.setViewCornerRadius(3)
        return BubbleView
    }()

    let contentView = UIView()
    var borderImage = UIImageView()

    private lazy var waveLayer1: CAShapeLayer = CAShapeLayer()
    private lazy var waveLayer2: CAShapeLayer = CAShapeLayer()
    private var  timer: CADisplayLink?
    public var rate: CGFloat = 0
    // 波浪位移 φ
    private var offsetX: CGFloat = 0
    // 波浪高度
    private var waveHeight: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
            rate = waveHeight / bounds.size.height
        }
    }
    // 波长里面几个波曲线（波峰和波谷为一个波曲线，比如在0~2π里面有个2个波曲线）
    public var wave: CGFloat = 1
    // 波纹振幅
    public var waveAmplitude: CGFloat = 0
    // 波纹周期 T = 2 *pi /|ω|
    public var waveCycle: CGFloat = 0
    // 波纹速度，用来累加到相位φ
    public var waveSpeed: CGFloat = 3
    // 波浪颜色
    public var color1: UIColor = UIColor.orange {
        didSet {
            wavelayer(waveLayer1, color: color1)
        }
    }
    public var color2: UIColor = UIColor.yellow {
        didSet {
            wavelayer(waveLayer2, color: color2)
        }
    }
    public var isBlack = false {
        didSet {
            if isBlack == true {
                borderImage.image = UIImage.pp_imageNamed( "heartbeat_border_b")
            } else {
                borderImage.image = UIImage.pp_imageNamed( "heartbeat_border")
            }
        }
    }

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            self.stop()
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        initializerWaveLayer()
    }
    public  override init(frame: CGRect) {
        super.init(frame: frame)
        viewHeight = self.height
        viewWeight = self.width
        initializerWaveLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializerWaveLayer() {

        self.backgroundColor = PPUIColor.bg2LightRedColor
        contentView.frame = self.bounds
        self.addSubview(contentView)

        borderImage.frame = self.bounds
        self.addSubview(borderImage)
        borderImage.image = UIImage.pp_imageNamed( "heartbeat_border")

        rate = 0.1
        waveCycle = wave * .pi / bounds.width * 1.3
        waveSpeed = 2.4
        contentView.layer.addSublayer(waveLayer1)
        contentView.layer.addSublayer(waveLayer2)
        addMaskView()
    }
    private func wavelayer(_ layer: CAShapeLayer, color: UIColor) {
        layer.frame = self.bounds
        layer.backgroundColor = UIColor.clear.cgColor
        layer.lineWidth = 0.5
        layer.strokeColor = UIColor.clear.cgColor
        layer.fillColor = color.cgColor
        layer.strokeStart = 0
        layer.strokeEnd = 1
    }
    // 开启波浪
    public func start() {
        if isHaveTime {
            return
        }
        isHaveTime = !isHaveTime
        wavelayer(self.waveLayer1, color: color1)
        wavelayer(self.waveLayer2, color: color2)
        timer = CADisplayLink.init(target: self, selector: #selector(self.handleTimer))
        timer?.preferredFramesPerSecond = 60
        timer?.add(to: RunLoop.current, forMode: .common)
    }

    /**
     处理displaylink事件，比较要注意的是当循环结束添加line
     wavePath1.addLine(to: CGPoint.init(x: bounds.width, y: bounds.height))
     wavePath1.addLine(to: CGPoint.init(x: 0, y: bounds.height))
     因为我的坐标系是自上而下的，因此注意最后两个点绘制坐标。
     */
    @objc private func handleTimer() {
        let wavePath1 = UIBezierPath()
        let wavePath2 = UIBezierPath()
        // 振幅系数，振幅越大波峰越陡
        waveAmplitude = bounds.height * 0.5 * 0.2
        // 正弦型函数解析式：y = A * sin(ωx+φ) + h  ω 读alpha
        var y1 = (1 - rate) * bounds.height
        var y2 = y1
        wavePath1.move(to: CGPoint.init(x: 0, y: y1))
        wavePath2.move(to: CGPoint.init(x: 0, y: y2))
        // 波长里面有几个波曲线可设置
        let a = waveCycle
        // 当offsetX趋近CGFloat maxValue值时这个值应减减防止奔溃
        if offsetX >= CGFloat.greatestFiniteMagnitude {
            offsetX = offsetX - waveSpeed
        } else {
            offsetX = offsetX + waveSpeed
        }
        // 峰值
        let h = (1 - rate) * bounds.height
        for x in 0...Int(bounds.width) {
            // 控制波浪1和波浪2的速度不同形成动画效果
            let f1 =  offsetX / bounds.width * .pi
            let f2 =  0.618 * offsetX / bounds.width * .pi
            y1 = waveAmplitude * CGFloat(sin(Double(a * CGFloat(x) + f1))) + (h - 2)
            y2 = waveAmplitude * CGFloat(sin(Double(a * CGFloat(x) + f2))) + h
            wavePath1.addLine(to: CGPoint.init(x: CGFloat(x), y: y1))
            wavePath2.addLine(to: CGPoint.init(x: CGFloat(x), y: y2))
        }
        wavePath1.addLine(to: CGPoint.init(x: bounds.width, y: bounds.height))
        wavePath1.addLine(to: CGPoint.init(x: 0, y: bounds.height))
        wavePath1.close()
        waveLayer1.path = wavePath1.cgPath

        wavePath2.addLine(to: CGPoint.init(x: bounds.width, y: bounds.height))
        wavePath2.addLine(to: CGPoint.init(x: 0, y: bounds.height))
        wavePath2.close()
        waveLayer2.path = wavePath2.cgPath
//        debugPrint("\(CACurrentMediaTime())")
    }
    // 停止波浪
    public func stop() {
        if timer != nil {
            timer?.remove(from: RunLoop.current, forMode: .common)
            timer?.invalidate()
            timer = nil
        }
        isHaveTime = false
    }
}
/// otherview

public extension WaveView {
    func addMaskView() {
        let imagev = UIImageView(frame: self.bounds)
        imagev.image = UIImage.pp_imageNamed("heartbeat")
        self.addSubview(imagev)
        self.layer.mask = imagev.layer
    }

    func addBubbleView() {
        if rate >= 0.45 && rate <= 1 {

            bubbleView.isHidden = false
            bubbleView.top =   (1 - rate) * bounds.height + 6
        } else {
            bubbleView.isHidden = true
        }
    }
    func removeBubbleView() {
        bubbleView.isHidden = true
    }

}

// MARK: - WaveView
public extension WaveView {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !haveMove {return}
        if viewHeight <= 0 {
            return
        }
        // 获取手指
        let touch = (touches as NSSet).anyObject() as! UITouch
        let nowLocation = touch.location(in: self)
        let preLocation = touch.previousLocation(in: self)
        // 获取两个手指的偏移量
        let offsetX = nowLocation.x - preLocation.x
        let offsetY = nowLocation.y - preLocation.y
        var center = self.center
        center.x += offsetX
        center.y += offsetY
        /** 左右极限坐标*/
        if center.x < viewHeight/2 {
            center.x = viewHeight/2
        } else if center.x > XHBScreenWidth - viewWeight/2 {
            center.x = XHBScreenWidth - viewWeight/2
        }
        /** 上下极限坐标*/
        if center.y < XHBStatusBarHeight + viewHeight/2 {
            center.y = XHBStatusBarHeight + viewHeight/2
        } else if center.y > XHBScreenHeight - XHBSafeAreaBottomMargin - viewHeight/2  - 64 {
            center.y = XHBScreenHeight - XHBSafeAreaBottomMargin - viewHeight/2 - 64
        }
        self.center = center
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !haveMove {return}
        if viewHeight <= 0 {
            return
        }
        UIView.animate(withDuration: 0.2) {
            if self.left >= XHBScreenWidth/2 {
                self.left = XHBScreenWidth - self.viewWeight - 16
//                self.com_cornerRadius(radius: 10, corners: [.topLeft, .bottomLeft])
            } else {
                self.left = 16
//                self.com_cornerRadius(radius: 10, corners: [.topRight, .bottomRight])
            }
        }
    }

}
