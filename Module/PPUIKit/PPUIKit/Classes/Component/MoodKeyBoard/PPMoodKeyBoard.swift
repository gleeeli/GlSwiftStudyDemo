//
//  MoodKeyBoard.swift
//  AdModule
//
//  Created by WJK on 2022/3/31.
//

import UIKit
import XHBSwiftKit
// import ConfigModule

public protocol MoodKeyBoardProtocol: AnyObject {
    func select(color: UIColor, colorKey: String, form: String)
    func clearSelect()
}

public class PPMoodKeyBoard: UIView {
    let itemWidth: CGFloat = 60.0
    public  weak var keyBoardDelegate: MoodKeyBoardProtocol?
    public  var text = "冲冲冲！干就完事了" {
        didSet {
            //            var tempString = text as NSString
            //            if tempString.length > 9 {
            //                tempString = tempString.substring(to: 9 ) as NSString
            //            }
            self.displayLabel.text = text
        }
    }

    var selectColor = ""
    var selectColorIndex =  -1 {
        didSet {
            if self.selectColorIndex > 0 {
                let colorKey = colorKeysArray[self.selectColorIndex]
                self.displayLabel.textColor = PPMoodColorManager.getTextColor(colorKey)
            } else {
                self.displayLabel.textColor = PPMoodColorManager.getTextColor("")
                self.setNormalStyle()
            }
            self.displayLabel.text =    self.displayLabel.text
        }
    }
    var selectLastColorIndex = -1

    var selectMoodIndex = -1
    var selectLastMoodIndex = -1

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: XHBScreenHeight, width: XHBScreenWidth, height: 308 + XHBSafeAreaBottomMargin))
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var animationName: [String] = {
        var array = [String]()
        return array
    }()

    lazy var moodJsonArray: [[String: String]] = {
        var array = [[String: String]]()
        if

            let plistPath = Bundle.pp_resourceBundle.path(forResource: "MoodKeyBordAnimationName", ofType: "json"),
            let url = URL(string: plistPath) {
            do {

                let data = try NSData.init(contentsOfFile: plistPath)
                let arrarTmp = try JSONSerialization.jsonObject(with: data! as Data, options: [])
                if  let arrarTmp = arrarTmp as? [[String: String]] {
                    array.append(contentsOf: arrarTmp)
                }
            } catch {}
        }
        return array
    }()

    lazy var colorKeysArray: [String] = {
        var array = [String]()
        for  (_, item)in self.colorKeyArray.enumerated() {
            if let color = item["key"] {
                array.append(color)
            }
        }
        return array
    }()

    lazy var colorArray: [String] = {
        var array = [String]()
        for  (_, item)in self.colorKeyArray.enumerated() {
            if let color = item["color"] {
                array.append(color)
            }
        }
        return array
    }()

    lazy var colorKeyArray: [[String: String]] = {
        let array = PPMoodColorManager.colorKeyArray
        return array
    }()
    /// 形状
    lazy var formkeys: [String] = {
        var array = [String]()
        return array
    }()

    var colorBtns = [UIButton]()
    var moodBtns = [UIButton]()

    var hintBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.pp_imageNamed("mood_color_hint"), for: .normal)
        btn.setTitle("心情", for: .normal)
        btn.titleLabel?.font = UIFont.peiPei.aliFontRegular(ofSize: 14)
        btn.layoutButtonImageEdgeInsetsStyle(style: .left, space: 5)
        btn.addTarget(self, action: #selector(hintBtnClick), for: .touchUpInside)
        btn.setTitleColor(PPUIColor.textStressBlackColor, for: .normal)
        return btn
    }()

    var colorBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.pp_imageNamed("mood_color_icon"), for: .normal)
        btn.setTitle("颜色", for: .normal)
        btn.titleLabel?.font = UIFont.peiPei.aliFontRegular(ofSize: 14)
        btn.layoutButtonImageEdgeInsetsStyle(style: .left, space: 5)
        btn.setTitleColor(PPUIColor.textStressBlackColor, for: .normal)
        btn.setBtnBackgroundColor(UIColor.white, for: .normal)

        return btn
    }()

    private lazy var contentView: UIView = {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        return view
    }()

    private lazy var displayBackImage: UIImageView = {
        let view = UIImageView()
        return view
    }()

    private lazy var displayLabel: SJRichLabel = {
        let view = PPMoodKeyBoard.createSJRichLabel()
        view.numberOfLines = 1
        view.textAlignment = .center
        view.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return view
    }()
    private lazy var displayAnimationLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.peiPei.aliFontRegular(ofSize: 15)
        view.textColor = .black
        return view
    }()
    private lazy var moodAnimationHeadView: PPMoodAnimationHeadView = {
        let view = PPMoodAnimationHeadView()
        return view
    }()

    public func setDefault(bg: String?, EmojiType: String?) {
        if let bg = bg, let EmojiType = EmojiType {
            // 设置
            if self.colorKeysArray.contains(bg)  &&  self.formkeys.contains(EmojiType) {
                let colorKeyIndex = self.colorKeysArray.firstIndex(of: bg)
                let formIndex = self.formkeys.firstIndex(of: EmojiType)
                self.selectColorIndex = colorKeyIndex ?? 0
                self.selectMoodIndex = formIndex ?? 0

                let btn1 = UIButton()
                btn1.tag = 1000 + (colorKeyIndex ?? 0)
                colorBtnClick(btn: btn1)

                let btn2 = UIButton()
                btn2.tag = 1000 + (formIndex ?? 0)
                moodBtnClick(btn: btn2)

            }

            return
        }
        let btn = UIButton()
        btn.tag = 999
        moodBtnClick(btn: btn) // 清理
    }

}
/// 点击事件
extension PPMoodKeyBoard {
    /// 提示
    @objc func hintBtnClick() {

    }
}
extension PPMoodKeyBoard {
    func setupUI() {
        self.addSubview(contentView)
        contentView.addSubview(hintBtn)
        contentView.addSubview(colorBtn)

        hintBtn.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(12)
            make.top.equalTo(contentView).offset(16)
        }

        colorBtn.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(122)
            make.left.equalTo(hintBtn)
        }
        self.layoutIfNeeded()
        let moodView = getMoodListView()
        contentView.addSubview(moodView)

        let colorView = getColorView()
        contentView.addSubview(colorView)

        creatDispalyView()

        setDisplayText()
    }

}

// MARK: 点击事件
extension PPMoodKeyBoard {
    /// tag -1000 颜色
    @objc func colorBtnClick(btn: UIButton) {
        let tagIndex = btn.tag - 1000
        seltctColorBtn(index: tagIndex)
        setDisplayText()
        callBack(clean: false)
    }

    /// tag -1000 第一个是清理按钮 形状
    @objc func moodBtnClick(btn: UIButton) {

        let tagIndex = btn.tag - 1000
        if  btn.tag  == 999 { // 清理
            cleanOtherMootBtns()
            cleanOtherColorBtns()
            setNormalStyle()
            self.selectLastColorIndex = -1
            self.selectColorIndex = -1
            self.selectLastMoodIndex = -1
            self.selectMoodIndex = -1
            callBack(clean: true)
            return
        }

        setNowMoodBtnColor(index: tagIndex)
        setDisplayText()
        callBack(clean: false)
    }

    func callBack(clean: Bool) {
        if clean {
            keyBoardDelegate?.clearSelect()
            return
        }
        let color =  UIColor(hexString: self.colorArray[self.selectColorIndex])
        let colorKey =  self.colorKeysArray[self.selectColorIndex]
        let form = self.formkeys[self.selectMoodIndex]
        keyBoardDelegate?.select(color: color, colorKey: colorKey, form: form)
    }
}
extension PPMoodKeyBoard {

    func setNowMoodBtnColor(index: Int) {
        self.selectMoodIndex = index
        cleanOtherMootBtns()

        if self.selectColorIndex == -1 {
            self.selectColorIndex = 0
            self.selectLastColorIndex = 0
            self.colorBtns[0].isSelected = true
        }

        self.moodBtns[index].backgroundColor = PPUIColor.P1Color
// =======
//
//        self.moodBtns[index].backgroundColor = PPUIColor.P1Color
// >>>>>>> feature/2022_06_1qi:NewPPConnect/Module/ConfigModule/ConfigModule/Classes/BaseClass/CustomUI/MoodKeyBoard/MoodKeyBoard.swift
        self.moodBtns[index].layer.borderWidth = 0
        selectLastMoodIndex = index
    }

    func seltctColorBtn(index: Int) {
        self.selectColorIndex = index

        cleanOtherColorBtns()

        self.colorBtns[selectColorIndex].isSelected = true
        self.selectLastColorIndex = index

        if self.selectMoodIndex <= -1 {
            self.selectMoodIndex = 0
            self.selectLastMoodIndex = 0
        }
        self.moodBtns[selectMoodIndex].backgroundColor = PPUIColor.P1Color
        self.moodBtns[selectMoodIndex].layer.borderWidth = 0
    }

    func cleanOtherMootBtns() {
        if self.selectLastMoodIndex == -1 {
            return
        }
        self.moodBtns[selectLastMoodIndex].backgroundColor = .white
        self.moodBtns[selectLastMoodIndex].layer.borderWidth = 1

    }

    func cleanOtherColorBtns() {
        if self.selectLastColorIndex == -1 {
            return
        }
        self.colorBtns[selectLastColorIndex].isSelected = false

    }
}

// MARK: 设置color
extension PPMoodKeyBoard {

    func getColorView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: itemWidth))
        let scroller = UIScrollView(frame: view.bounds)
        view.addSubview(scroller)
        let leftcheap = itemWidth + 8

        for (index, item) in colorArray.enumerated() {

            let btn = getColorBtn(color: item)
            scroller.addSubview(btn)
            btn.left = CGFloat((index)) * leftcheap + 12
            btn.addTarget(self, action: #selector(colorBtnClick(btn:)), for: .touchUpInside)
            btn.tag = 1000 + index
            colorBtns.append(btn)

        }

        scroller.contentSize = CGSize(width: leftcheap * CGFloat(colorArray.count ), height: 0)
        view.top  = 152
        return view
    }

    func getColorBtn(color: String) -> UIButton {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: itemWidth, height: itemWidth))
        btn.setViewCornerRadius( btn.height / 2.0)
        btn.backgroundColor = UIColor(hexString: color)
        btn.setImage(UIImage.pp_imageNamed("mood_select"), for: .selected)
        btn.setImage(nil, for: .normal)
        return btn
    }
}

// MARK: 设置形状
extension PPMoodKeyBoard {

    func createMoodBtnWithJson(title: String, iconName: String) -> UIButton {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: itemWidth, height: itemWidth))
        btn.setViewCornerRadius( btn.height / 2.0)

        let titleLanel = getNameLabel(title: title)
        let animationView = getFormImageView(iconName: iconName)

        btn.addSubview(animationView)
        animationView.top = 0
        animationView.centerX = btn.width / 2.0
        btn.addSubview(titleLanel)
        titleLanel.top = 36
        titleLanel.centerX = btn.width / 2.0
        btn.layer.borderColor = SWIFT_RGBACOLOR(51, 51, 51, 0.4).cgColor
        btn.layer.borderWidth = 1
        btn.setBtnBackgroundColor(UIColor.white, for: .normal)
        btn.setBtnBackgroundColor(PPUIColor.P1Color, for: .selected)
        return btn
    }

    func getNameLabel(title: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.peiPei.aliFontBold(ofSize: 11)
        label.textColor = PPUIColor.bgNormalBlackColor
        label.text = title
        label.sizeToFit()
        return label
    }

    //    func getAnimationView(iconName:String) -> LOTAnimationView {
    //        //比例 165 75
    //        let animationView = LOTAnimationView()
    //        animationView.mcm_setAnimationNamed(iconName)
    //        animationView.frame = CGRect(x: 0 , y: 0 , width: itemWidth, height: 75.0 * itemWidth / 165.0)
    //        animationView.isUserInteractionEnabled = false
    //        return animationView
    //    }

    func getFormImageView(iconName: String) -> UIImageView {
        let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageV.image = UIImage.pp_imageNamed(iconName)
        return imageV
    }

    func getMoodListView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: itemWidth))
        let scroller = UIScrollView(frame: view.bounds)
        view.addSubview(scroller)
        let leftcheap = itemWidth + 8

        let clearnBtn = creatCleanBtn()
        clearnBtn.left = 12
        clearnBtn.tag = 999
        scroller.addSubview(clearnBtn)
        clearnBtn.addTarget(self, action: #selector(moodBtnClick(btn:)), for: .touchUpInside)

        for (index, item) in moodJsonArray.enumerated() {
            if let title = item["title"],
               let iconName = item["iconName"] {
                self.animationName.append(iconName)
                let btn = createMoodBtnWithJson(title: title, iconName: iconName)

                scroller.addSubview(btn)
                btn.left = CGFloat((index + 1)) * leftcheap + 12
                btn.addTarget(self, action: #selector(moodBtnClick(btn:)), for: .touchUpInside)
                btn.tag = 1000 + index

                moodBtns.append(btn)
                formkeys.append(iconName)
            }
        }
        scroller.contentSize = CGSize(width: leftcheap * CGFloat(moodJsonArray.count + 1), height: 0)
        view.top  = 46
        return view
    }

    func creatCleanBtn() -> UIButton {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: itemWidth, height: itemWidth))
        btn.setViewCornerRadius( btn.height / 2.0)
        btn.setImage(UIImage.pp_imageNamed("mood_close"), for: .normal)
        btn.layer.borderColor = SWIFT_RGBACOLOR(51, 51, 51, 0.4).cgColor
        btn.layer.borderWidth = 1
        return btn
    }
}
extension PPMoodKeyBoard {

    func setDisplayText() {
        //        if NSString.isEmpty(self.displayLabel.text) {
        //            self.displayLabel.text = "冲冲冲！干就完事了"
        //        }
        if self.selectMoodIndex == -1 {
            setNormalStyle()
            return
        }
        self.moodAnimationHeadView.isHidden = false
        if let colorKey = colorKeyArray[self.selectColorIndex]["key"] {
            let formKey = formkeys[self.selectMoodIndex]
            self.displayBackImage.image = UIImage.pp_imageNamed(colorKey + "_r")
            self.moodAnimationHeadView.setanimationName(colorKey, formName: formKey, directionIsMy: true)
        }
    }

    func setNormalStyle() {
        self.displayBackImage.image = UIImage.pp_imageNamed("cm_img_my")
// =======
//    func setNormalStyle() {
//        self.displayBackImage.image = UIImage.config_imageNamed("cm_img_my")
// >>>>>>> feature/2022_06_1qi:NewPPConnect/Module/ConfigModule/ConfigModule/Classes/BaseClass/CustomUI/MoodKeyBoard/MoodKeyBoard.swift
        self.moodAnimationHeadView.isHidden = true
    }

    func creatDispalyView() {
        let displayView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: 80))
        self.contentView.addSubview(displayView)
        displayView.top = 232

        displayView.addSubview(displayBackImage)
        displayView.addSubview(displayLabel)
        displayView.addSubview(moodAnimationHeadView)

        displayLabel.snp.makeConstraints { make in
            make.left.equalTo(displayBackImage).offset(10)
            make.right.equalTo(displayBackImage).offset(-10)
            //            make.top.equalTo(displayBackImage).offset(10)
            make.bottom.equalTo(displayBackImage).offset(-10)
            make.width.equalTo(141)
        }

        moodAnimationHeadView.snp.makeConstraints { make in
            make.right.equalTo(displayBackImage.snp.right)
            make.bottom.equalTo(displayBackImage.snp.top)

        }
        displayBackImage.snp.makeConstraints { make in
            make.center.equalTo(displayView.snp.center)
            make.height.equalTo(40)
        }

    }
}

// MARK: 计算文本大小
extension PPMoodKeyBoard {

    static func createSJRichLabel() -> SJRichLabel {

        let TextFont_m = UIFont.peiPei.aliFontRegular(ofSize: CGFloat(FONT_P6))  // 提示语字体
        let ChatTextColor = PPUIColor.bgNormalBlackAlpha08Color   // 文本颜色
        let EmojiOffsetLineHeight: CGFloat = -0.05   // 聊天界面表情倍数
        let  EmojiMultiple: CGFloat = 1.28   // 聊天界面表情倍数

        let textLab = SJRichLabel()
        textLab.textAlignment = .left
        textLab.lineSpacing = 3
        textLab.isUserInteractionEnabled = true
        textLab.font = TextFont_m
        textLab.textColor = ChatTextColor
        textLab.emojiWidthRatioWithLineHeight = EmojiMultiple
        textLab.emojiOriginYOffsetRatioWithLineHeight = EmojiOffsetLineHeight
        return textLab
    }

    static func getContentTextSize(text: String, maxW: CGFloat, font: UIFont) -> CGSize {
        let textlabe = createSJRichLabel()
        textlabe.text = text

        var size = textlabe.preferredSize(withMaxWidth: maxW)
        if size.height > 30 {
            size.width = maxW
        }
        return size
    }
}
