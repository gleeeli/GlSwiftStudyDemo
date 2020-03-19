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
    var titles = ["策略模式","非策略模式的普通方式实现","tableview的顶部刷新","命令模式","异常"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"];
        var reversedNames = names.sorted(by: backward)
        print(reversedNames);
        
        _ = { reversedNames.remove(at: 0) }
        print(reversedNames.count)
        // 打印出 "5"
        
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
        if content == "策略模式" {
            
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
        }
        
        
    }
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
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

