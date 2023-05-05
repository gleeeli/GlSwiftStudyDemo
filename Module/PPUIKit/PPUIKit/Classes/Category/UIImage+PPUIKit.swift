//
//  UIImage+PPUIKit.swift
//  PPUIKit
//

//  Created by WJK on 2022/6/13.
//

import Foundation
import Lottie
import FLAnimatedImage

@objc public extension UIImage {
    class func pp_imageNamed(_ name: String) -> UIImage {

        return UIImage(named: name, in: Bundle.pp_assetBundle, compatibleWith: nil) ?? UIImage()
    }

    class func pp_animatedGifNamed(_ name: String) -> FLAnimatedImage {
        let scale = UIScreen.main.scale
        var tmpPath: String?
        let bunle =  Bundle.pp_resourceBundle
        if scale > 1.0 {
            tmpPath = bunle.path(forResource: name.appending("@2x"), ofType: "gif")
            var data = NSData(contentsOfFile: tmpPath ?? "")
            if data != nil {
                return FLAnimatedImage.init(animatedGIFData: data! as Data)
            }

            tmpPath = bunle.path(forResource: name, ofType: "gif")
            data = NSData(contentsOfFile: tmpPath ?? "")
            if data != nil {
                return FLAnimatedImage.init(animatedGIFData: data! as Data)
            }
            tmpPath = Bundle.main.path(forResource: name, ofType: "gif")
            data = NSData(contentsOfFile: tmpPath ?? "")
            if data != nil {
                return FLAnimatedImage.init(animatedGIFData: data! as Data)
            }
        } else {
            tmpPath = bunle.path(forResource: name, ofType: "gif")
            let data = NSData(contentsOfFile: tmpPath ?? "")
            if data != nil {
                return FLAnimatedImage.init(animatedGIFData: data! as Data)
            }
        }
        return FLAnimatedImage.init()
    }

    // UIView转UIImage
    class func getImageFromViewPP(view: UIView) -> UIImage {
        // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。
        // 如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(view.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        view.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

public extension UIImage {
    /// 高斯模糊，磨玻璃
    func boxBlurImage(blur: Float, resultBlock: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            let context = CIContext.init(options: nil)
            let inputImage = CIImage.init(image: self)
            let filter = CIFilter.init(name: "CIGaussianBlur")
            filter?.setValue(inputImage, forKey: kCIInputImageKey)
            filter?.setValue(blur, forKeyPath: "inputRadius")
            // --> CIImage
            let outputImage = filter?.value(forKey: kCIOutputImageKey) as! CIImage
            // --> CGImage
            let resultImage: CGImage? = context.createCGImage(outputImage, from: inputImage!.extent)
            // --> UIImage
            let newImage =  UIImage.init(cgImage: resultImage!)
            DispatchQueue.main.async {
                resultBlock(newImage)
            }
        }
    }

}
