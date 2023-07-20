//
//  ViewController.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2018/9/12.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .grouped);
//    var titles = [String]()
    var titles = ["CoreText","策略模式","非策略模式的普通方式实现","tableview的顶部刷新","命令模式","异常","block使用","RxSwift使用","日期","字符串和富文本","翻页效果","模糊效果","滚动渐变","上下滚动文字效果","OC类","自定义有优先级的弹窗","UIButton"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        
       
        
        let newarray = multipleReturn(num: [1,2,3]);
        print(newarray as Any)
        
        canChangeNumsParameters(param: 1,2,3)
    }
    
    func initTableView() {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        self.view.addSubview(tableView);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("功能点个数\(titles.count)")
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let content = titles[indexPath.row]
        
        cell.textLabel?.text = content
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = titles[indexPath.row]
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        if content == "CoreText" {
            let vc = CoreTextExampleViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "策略模式" {
            
            let vc = sb.instantiateViewController(withIdentifier: "StrategyViewController") as! StrategyViewController;
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "非策略模式的普通方式实现" {
            
            let vc = sb.instantiateViewController(withIdentifier: "NotStrategyViewController") as! NotStrategyViewController;
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "tableview的顶部刷新" {
            
            let vc = TableViewTopScaleImageViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "命令模式" {
            
            let vc = CommandViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "异常" {
            
            let vc = ThrowExceptViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "block使用" {
            
            let vc = BlockViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "RxSwift使用" {
            
            let vc = RxExampleViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "日期" {
            
            let vc = DateViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "字符串和富文本" {
            let vc = StringAndAttributeTextVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "翻页效果" {
            let vc = ZXFCardsVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "模糊效果" {
            let vc = BlurEffectExampleViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "滚动渐变" {
            let vc = GunDongSelViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "上下滚动文字效果" {
            let vc = TitleCycleScrollViewViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "lottie" {
            let vc = LottieViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "OC类" {
            let vc = ObjectiveCViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "自定义有优先级的弹窗" {
            let vc = UIAlertViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if content == "UIButton" {
            let vc = ButtonStyleViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    func multipleReturn(num:[Int]) -> (min:Int,max:Int)?{
        if num.isEmpty {
            return nil
        }
        return (0, 100)
    }
    
    func canChangeNumsParameters(param:Int...) -> () {
        for num in param {
            print("可变数组内容为:\(num)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

