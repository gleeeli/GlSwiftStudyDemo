//
//  CommandViewController.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2018/9/13.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class CommandViewController: UIViewController {
    let reciver = Rceiver()
    let invoker  = Invoker()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showView = UIView(frame: CGRect(x: 10, y: 74, width: SCREEN_WIDTH - 20, height: 50));
        showView.layer.cornerRadius = 25;
        showView.layer.masksToBounds = true;
        self.view.addSubview(showView);
        
        reciver.targetView = showView;
        
        invoker.runCommand(command: GradientCommand(receiver: reciver, colors: [UIColor.red.cgColor,UIColor.yellow.cgColor,UIColor.green.cgColor]))
        
        let trect = showView.frame
        
        let baojiBtn = UIButton.init(type: UIButtonType.system)
        baojiBtn.frame = CGRect(x: 10, y: trect.maxY + 20, width: 100, height: 50)
        baojiBtn.setTitle("变色", for: UIControlState.normal)
        baojiBtn.addTarget(self, action: #selector(changeColorBtnClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(baojiBtn)
        
        let backBtn = UIButton.init(type: UIButtonType.system)
        backBtn.frame = CGRect(x: baojiBtn.frame.maxX + 10, y: trect.maxY + 20, width: 100, height: 50)
        backBtn.setTitle("后退", for: UIControlState.normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(backBtn)
        
        let testView = UIView(frame: CGRect(x: 10, y: backBtn.frame.maxX, width: 150, height: 50))
        testView.backgroundColor = UIColor.green
        self.view.addSubview(testView)
        
//        let bAnimation = CABasicAnimation(keyPath: "bounds")//strokeEnd bounds
//        bAnimation.duration = 5;
//        bAnimation.toValue = CGRect(x: 0, y: 0, width:200, height: 50);
//        testView.layer.add(bAnimation, forKey: "bounds")
        
//        let kAnimation = CAKeyframeAnimation(keyPath: "bounds")//strokeEnd bounds
//        kAnimation.duration = 5;
//        kAnimation.values = [CGRect(x: 0, y: 0, width:0, height: 50),CGRect(x: 0, y: 0, width: 150, height: 50)];
//        testView.layer.add(kAnimation, forKey: "bounds")
        
//        let sView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        sView.backgroundColor = UIColor.red
//        sView.layer.anchorPoint = CGPoint(x: 0, y: 0)
//        sView.layer.position = CGPoint(x: 0, y: 0)
//        testView.addSubview(sView)
//
//        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//            sView.transform = CGAffineTransform(scaleX: 2.0, y: 1)
//        }, completion: nil)
        
    }
    
    @objc func changeColorBtnClick() {
        let colorsAll:[UIColor] = [UIColor.red,UIColor.orange,UIColor.yellow,UIColor.green,UIColor.cyan,UIColor.blue,UIColor.purple]
        let startColor  = colorsAll[getRandomNum()]
        let endColor  = colorsAll[getRandomNum()]
        
        invoker.runCommand(command: GradientCommand(receiver: reciver, colors: [startColor.cgColor,endColor.cgColor]))
    }
    
    @objc func backBtnClick(){
        invoker.back()
    }
    
    func getRandomNum() -> Int {
        let randomNumber:Int = Int(arc4random() % 6)
        return randomNumber;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
