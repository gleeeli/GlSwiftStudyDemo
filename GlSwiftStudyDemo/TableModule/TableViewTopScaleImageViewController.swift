//
//  TableViewTopScaleImageViewController.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2018/9/13.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

import UIKit


class TableViewTopScaleImageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var muArray:NSMutableArray = NSMutableArray.init();
    let tableview = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
    let tableHeaderView = GlTableHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 200));
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return muArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = muArray.object(at: indexPath.row) as? String
        return cell;
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        muArray .add("gleeeli test 1")

        tableview.delegate = self;
        tableview.dataSource = self;
        tableview .register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableview.tableHeaderView = tableHeaderView;
        self.view.addSubview(tableview)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableHeaderView .scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }

    override func didReceiveMemoryWarning() {

    }

}
