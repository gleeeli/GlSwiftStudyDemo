//
//  GunDongSelViewController.swift
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2023/3/3.
//  Copyright © 2023 gleeeli. All rights reserved.
//

import UIKit
import SnapKit

class GunDongSelViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 80
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        let picker = UIPickerView(frame: CGRect(x: 0, y: 100, width: 320, height: 320))
        picker.delegate = self
        picker.showsSelectionIndicator = false
        self.view.addSubview(picker)
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 60))
        backView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        backView.layer.cornerRadius = 8
        backView.layer.masksToBounds = true
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.red
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.text = "row:\(row)"
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        return backView
    }

    

}
