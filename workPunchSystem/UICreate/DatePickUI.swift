//
//  datePickUI.swift
//  workPunchSystem
//
//  Created by 李晉杰 on 2022/7/8.
//

import UIKit

class DatePickUI: UIViewController {
    var datepicker = UIDatePicker()
    var label = UILabel()
    let WIDTH = UIScreen.main.bounds.size.width
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func datePick() -> UIView{
        view.backgroundColor = .lightGray
            label.frame.size = CGSize(width: 250,
                                      height: 50)
            label.center = CGPoint(x: WIDTH / 2,
                                   y: 100)
            label.text = "點擊選擇日期"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 13)
            label.textAlignment = .center
            label.backgroundColor = .white
            label.layer.borderWidth = 2
            label.layer.borderColor = UIColor.black.cgColor
            label.isUserInteractionEnabled = true // 設定可互動
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(labelpressed)) // 加入觸發條件
            label.addGestureRecognizer(tap) // 加入觸發動作
        return label
//        view.addSubview(label)
    }
    @objc func labelpressed(sender: UIButton) {
        let datealert = UIAlertController(title: "\n\n\n\n",
                                          message: "",
                                          preferredStyle: .actionSheet)
                // frame
                datepicker.frame = CGRect(x: 0,
                                          y: 0,
                                          width: datealert.view.frame.width - 2.5 * 8,
                                          height: 130)
                // 語言
                datepicker.locale = Locale(identifier:"zh_CN")
                // 分鐘間隔
                //datepicker.minuteInterval = 5
                // 預設日期為今天
                datepicker.date = NSDate() as Date
                // 輸入格式
                //DateFormatter().dateFormat = "yyyy-MM-dd"
                // 最早日期
                //datepicker.minimumDate = DateFormatter().date(from: "2015-01-01")
                // 最晚日期
                //datepicker.maximumDate = DateFormatter().date(from: "2017-12-31")
                // 選擇模式
                datepicker.datePickerMode = .date
                /*
                UIDatePickerMode
                 .countDownTimer      小時, 分鐘
                 .date                日期
                 .dateAndTime         日期, 時間
                 .time                時間
                 */
                // 加入動作
                datepicker.addTarget(self,
                                     action: #selector(self.dateChanged),
                                     for: .valueChanged)
            datealert.view.addSubview(self.datepicker)

                let cancel = UIAlertAction(title: "清除",
                                           style: .cancel,
                                           handler: {(action: UIAlertAction!) -> Void in
                                                self.label.text = "點擊選擇日期"
                                            })
            datealert.addAction(cancel)

                let done = UIAlertAction(title: "確認",
                                         style: .default,
                                         handler: nil)
            datealert.addAction(done)
        present(datealert,
                animated: true,
                completion: nil)
    }

    @objc func dateChanged(datePicker: UIDatePicker) {
        DateFormatter().dateFormat = "yyyy 年 MM 月 dd 日"
        /*
         yyyy     ex. 2017, 2016
         yy       ex. 17, 16 (西元末兩位數字)
         MMMM     ex. January, February
         MMM      ex. Jan, Feb
         MM       ex. 01, 02 (月份)
         dd       ex. 01, 02 (日期)
         EEEE     ex. Sunday, Monday
         EEE      ex. Sun, Mon
         HH       ex. 13, 14 (24小時制)
         hh       ex. 01, 02 (12小時制)
         mm       ex. 分
         ss       ex. 秒
         */
        self.label.text = DateFormatter().string(from: datePicker.date)
    }
}
