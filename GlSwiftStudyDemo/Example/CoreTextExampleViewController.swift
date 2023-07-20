//
//  CoreTextExampleViewController.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/7/18.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import UIKit
import SnapKit

class CoreTextExampleViewController: UIViewController {
    
    let cView = CoreTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        
        cView.backgroundColor = .white
        self.view.addSubview(cView)
        cView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
        
        for i in 0..<5 {
            print("当前i:\(i)")
        }
    }
}

/*CTFrame可以想象成一个画布，画布的大小范围由CGPath决定
 CTFrame由很多CTLine组成，CTLine表示为一行CTLine由多个CTRun组成，CTRun相当于一行中的多个块（格式为一致的字为一个块）
 但是CTRun不需要你自己创建，由NSAttributedString的属性决定，系统自动生成。每个CTRun对应不同属性。
 CTFramesetter是一个工厂，创建CTFrame，一个界面上可以有多个CTFrame
 CTFrame就是一个基本画布，然后一行一行绘制。CoreText会自动根据传入的NSAttributedString属性创建CTRun,包括字体样式，颜色，间距等
 
 作者：傲骨天成科技
 链接：https://www.jianshu.com/p/9987e6194b2e
 来源：简书
 */
class CoreTextView: UIView {
    let curWay = 3
    override func draw(_ rect: CGRect) {
        //step 1:获取当前画布的上下文，用于后续将内容绘制在画布上
        if let context = UIGraphicsGetCurrentContext() {
            let path = CGMutablePath()
            path.addRect(self.bounds)
            
            //将坐标系进行翻转,因为CoreText默认坐标原点在左下角
            context.textMatrix = CGAffineTransformIdentity
            context.translateBy(x: 0, y: self.bounds.size.height)//更改坐标系原点
            context.scaleBy(x: 1.0, y: -1.0)//在上下文中更改用户坐标系的比例。
            
            
            let attributedString = NSAttributedString(string: "获取当前画布的上下文，用于后续将内容绘制在画布上,在上下文中更改用户坐标系的比例。将坐标系进行翻转,因为CoreText默认坐标原点在左下角")
            //CTFramesetterRef 可管理多个CTFrameRef
            let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
            //CTFrameRef
            let frame = CTFramesetterCreateFrame(framesetter, CFRange(location: 0, length: attributedString.length), path, nil)
            if (self.curWay == 0) {
                
                
                CTFrameDraw(frame, context)
            }else if (self.curWay == 1){
                self.way1CTLine(frame: frame, context: context)
            }else if (self.curWay == 2){
                self.way2CTRun(frame: frame, context: context)
            }else if (self.curWay == 3){
                self.drawTextAndImg(context: context, path: path)
            }
            //            CFRelease(frame)
            //            CFRelease(path)
            //           CFRelease(framesetter)
        }
        
    }
    
    //方式一用CTLine绘制
    func way1CTLine(frame: CTFrame, context: CGContext) {
        // 通过CTLine
        // 1.获得CTLine数组
        let lines: CFArray = CTFrameGetLines(frame);
        // 2.获得行数
        let indexCount: CFIndex = CFArrayGetCount(lines);
        // 3.获得每一行的origin, CoreText的origin是在字形的baseLine（基准线）处
        //            CGPoint origins[indexCount];
        var origins = CGPoint()
        //var origins = CGPoint[](count: indexCount, repeatedValue: CGPointZero)
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &origins);
        // 4.遍历每一行进行绘制
        for i in 0..<indexCount {
            let linePoint = CFArrayGetValueAtIndex(lines, i);
            let line = unsafeBitCast(linePoint, to: CTLine.self)
            print("line:\(line)")
            CTLineDraw(line, context);
        }
    }
    
    //方式一用CTRun绘制
    func way2CTRun(frame: CTFrame, context: CGContext) {
        // 通过CTLine
        // 1.获得CTLine数组
        let lines: CFArray = CTFrameGetLines(frame);
        // 2.获得行数
        let indexCount: CFIndex = CFArrayGetCount(lines);
        // 3.获得每一行的origin, CoreText的origin是在字形的baseLine（基准线）处
        //            CGPoint origins[indexCount];
        var origins = CGPoint()
        //var origins = CGPoint[](count: indexCount, repeatedValue: CGPointZero)
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &origins);
        
        
        // 4.遍历每一行进行绘制
        for i in 0..<indexCount {
            let linePoint = CFArrayGetValueAtIndex(lines, i);
            let line = unsafeBitCast(linePoint, to: CTLine.self)
            
            let runs: CFArray = CTLineGetGlyphRuns(line)
            let runCount: CFIndex = CFArrayGetCount(runs)
            for i in 0..<runCount {
                
                let runP = CFArrayGetValueAtIndex(runs, i)
                let run = unsafeBitCast(runP, to: CTRun.self)
                CTRunDraw(run, context, CFRange(location: 0, length: 0))
            }
        }
        
    }
    
    func drawTextAndImg(context: CGContext, path: CGPath) {
        let ImgRunDelegateDeallocCallback: @convention(c)(UnsafeMutableRawPointer) -> Void = {_ in
            
        }
        
        let ImgRunDelegateGetAscentCallback: @convention(c)(UnsafeMutableRawPointer) -> CGFloat = {refCon in
            let pInt2 = refCon.assumingMemoryBound(to: Int8.self)
            
            let imageName = String(cString: pInt2)
    
            let height = UIImage(named: imageName)?.size.height
            print("获取到图片:\(imageName),高度：\(String(describing: height))")
            return height ?? 0
        }
        
        let ImgRunDelegateGetDescentCallback: @convention(c)(UnsafeMutableRawPointer) -> CGFloat = {_ in
            
            return 0
        }
        
        let ImgRunDelegateGetWidthCallback: @convention(c)(UnsafeMutableRawPointer) -> CGFloat = {_ in
            
            return 80
        }
        
        var imageCallBacks: CTRunDelegateCallbacks = CTRunDelegateCallbacks(version: kCTRunDelegateCurrentVersion, dealloc: ImgRunDelegateDeallocCallback, getAscent: ImgRunDelegateGetAscentCallback, getDescent: ImgRunDelegateGetDescentCallback, getWidth: ImgRunDelegateGetWidthCallback)
        
        var imageNameStr: String = "test2.png"
        
        
        var imgAttributeStr = NSMutableAttributedString(string: " ")
        
        if let imgRunDelegate = CTRunDelegateCreate(&imageCallBacks, &imageNameStr) {
            let keyStr: String = "\(kCTRunDelegateAttributeName)"
            let attrkey = NSAttributedStringKey(rawValue: keyStr)
            imgAttributeStr.addAttributes([attrkey: imgRunDelegate], range: NSRange(location: 0, length: 1))
        }
        
        
        let attrString = NSMutableAttributedString(string: "Worl按季度交发十大减肥；阿技术点发觉啊；啥的积分；阿斯加德发；安静是的；发jakdfads;fjas;lsd f安静的首付款撒；时间点发；安静都是；发觉啊；是的发；啊打发；")
        
        // 图片占位符添加
        imgAttributeStr.addAttributes([NSAttributedStringKey(rawValue:"imgName"):"test2.png"], range: NSMakeRange(0, 1))
        attrString.insert(imgAttributeStr, at: 10)
        
        let frameSetter = CTFramesetterCreateWithAttributedString(attrString)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: attrString.length), path, nil)
        
        CTFrameDraw(frame, context)
        
        let lines = CTFrameGetLines(frame)
        let indexCount = CFArrayGetCount(lines)
        var lineOrigins = [CGPoint](repeating: CGPointZero, count: indexCount)
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &lineOrigins);
        
        for i in 0..<indexCount {
            let lineP = CFArrayGetValueAtIndex(lines, i)
            let line = unsafeBitCast(lineP, to: CTLine.self)
            
            var lineAscent: CGFloat = 0 //上缘线
            var lineDescent: CGFloat = 0 //下缘线
            var lineLeading: CGFloat = 0 //行间距
            // 获取此行的字形参数
            CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading)
            // 获取此行中每个CTRun
            let runs = CTLineGetGlyphRuns(line);
            let runCount = CFArrayGetCount(runs);
            print("+++++++++++++++第\(i)行开始+++++++++++++++")
            for j in 0..<runCount {
                var runAscent: CGFloat = 0//此CTRun上缘线
                var runDescent: CGFloat = 0//此CTRun下缘线
                var runLeading: CGFloat = 0//CTRun间距
                var lineOrigin = lineOrigins[i];//此行起点
                
                let runP = CFArrayGetValueAtIndex(runs, j)
                let run = unsafeBitCast(runP, to: CTRun.self)
                let runAttributeds = CTRunGetAttributes(run) as? [AnyHashable: Any];
                
                var runRect: CGRect = CGRect.zero;
                // 获取此CTRun的上缘线、下缘线，并由此获取CTRun和宽
                runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, &runLeading);
                
                // CTRun的X坐标
                let runOrgX = lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, nil);
                runRect = CGRectMake(runOrgX, lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
                // 通过run的属性特征获得图片名称的字符串
                print("runRect:\(runRect),runAttributeds:\(runAttributeds ?? [:])")
                if let imgName: String = runAttributeds?["imgName"] as? String {
                    print("图片名称===\(imgName)");
                    if let image = UIImage(named: imgName), let cgImage = image.cgImage {
                        var imageRect = CGRect.zero
                        imageRect.size = CGSizeMake(40, 20);
                        imageRect.origin.x = runRect.origin.x + lineOrigin.x
                        imageRect.origin.y = lineOrigin.y
                        
                        context.draw(cgImage, in: imageRect)
                    }
                    
                }else {
                    print("图片名称===nil");
                }
                
            }
        }
    }
}


//void ImgRunDelegateDeallocCallback(void *refCon) {
//
//}
