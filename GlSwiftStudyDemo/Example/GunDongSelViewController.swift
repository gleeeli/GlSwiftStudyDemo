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
    
    
    private lazy var datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 200))
        let maxDate = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
        let minDate = Calendar.current.date(byAdding: .year, value: -35, to: Date()) ?? Date()
//        datePicker.maximumDate = maxDate
//        datePicker.minimumDate = minDate

        let d = DateFormatter.init()
        d.dateFormat =  "yyyy-MM-dd"
        datePicker.date = d.date(from: "2000-06-01") ?? minDate
        datePicker.tintColor = PPUIColor.red
        datePicker.locale = Locale.init(identifier: "zh_Hans_CN")
        datePicker.setValue(PPUIColor.red, forKeyPath: "textColor")
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor.white
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
//        let picker = UIPickerView(frame: CGRect(x: 0, y: 100, width: 320, height: 320))
//        picker.delegate = self
//        picker.showsSelectionIndicator = false
//        self.view.addSubview(picker)
        
        
        self.view.addSubview(self.datePickerView)
        
        self.datePickerView.setValue(UIColor.red, forKeyPath: "textColor")
//        self.datePickerView.setValue(false, forKey: "highlightsToday")
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

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 80
    }

}
