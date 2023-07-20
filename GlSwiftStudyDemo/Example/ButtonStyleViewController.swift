//
//  ButtonStyleViewController.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/5/30.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import UIKit
import SnapKit

class ButtonStyleViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = PPCustomButton()
        button.isUserLayout = true
        button.setImage(UIImage(named: "100x100"), for: .normal)
        button.setTitle("天下归一", for: .normal)
        
        
        button.backgroundColor = UIColor.gray
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        
        let button2 = PPCustomButton()
        
        button2.setImage(UIImage(named: "100x100"), for: .normal)
        button2.setTitle("天下归二", for: .normal)
        
        
        button2.backgroundColor = UIColor.gray
        self.view.addSubview(button2)
        button2.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.trailing).offset(5)
            make.centerY.equalTo(button)
        }
        
    }

}
