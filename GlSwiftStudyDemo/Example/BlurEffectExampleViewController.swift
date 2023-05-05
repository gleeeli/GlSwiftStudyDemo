//
//  BlurEffectExampleViewController.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/2/26.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import UIKit

class BlurEffectExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 50, y: 100, width: 200, height: 200))
        
        self.view.addSubview(imageView)

        // Do any additional setup after loading the view.
        if let image = UIImage(named: "fengjing")?.cgImage {
            let newimage = test(cgimage: image)
            imageView.image = newimage
        }
        
    }
    

    func test(cgimage : CGImage) -> UIImage? {
       
        let imageToBlur = CIImage.init(cgImage: cgimage)
        guard let gaussianBlurFilter: CIFilter = CIFilter(name: "CIGaussianBlur") else {
            return nil
        }
        gaussianBlurFilter.setValue(imageToBlur, forKey: "inputImage")
        gaussianBlurFilter.setValue(15, forKey: "inputRadius")
        if let resultImage: CIImage = gaussianBlurFilter.value(forKey: "outputImage") as? CIImage {
            let blurEffectImage = UIImage(ciImage: resultImage)
            
            return blurEffectImage
        }
        
        return nil
    }

}
