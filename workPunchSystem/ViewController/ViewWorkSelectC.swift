//
//  ViewWorkSelectC.swift
//  workPunchSystem
//
//  Created by 李晉杰 on 2022/7/8.
//

import UIKit

class ViewWorkSelectC: UIViewController {
    var datepicker = UIDatePicker()
    var label = UILabel()
    let WIDTH = UIScreen.main.bounds.size.width
    @IBOutlet weak var orderStateBtn: UIButton!
    @IBOutlet weak var orderClassBtn: UIButton!
    @IBOutlet weak var startDatePickBtn: UIDatePicker!
    @IBOutlet weak var endDatePickBtn: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        var titleView = NavigationViewUI().navCreate()
        self.navigationItem.titleView = titleView
        orderStateBtn.setTitle("請選擇", for: .normal)
        orderClassBtn.setTitle("請選擇", for: .normal)
        themeMenu()
        startDatePickBtn.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        endDatePickBtn.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    @objc private func dateChanged() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func endDatePickBnt(_ sender: UIDatePicker) {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M/d"
        let endDate = formatter.string(from: sender.date)
        print(endDate)
        
    }
    @IBAction func startDatePickBtn(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
         formatter.dateFormat = "yyyy/M/d"
         let startDate = formatter.string(from: sender.date)
         print(startDate)
    }
    func themeMenu() {//下拉選單
        let theme_1 = UIAction(title: "全部", image: UIImage(systemName: "pencil")) { _ in
            UIApplication.shared.keyWindow?.showToast(text:"全部")
            self.orderStateBtn.setTitle("全部", for: .normal)
        }
        let theme_2 = UIAction(title: "已進行", image: UIImage(systemName: "pencil")) { _ in
            UIApplication.shared.keyWindow?.showToast(text:"已進行")
            self.orderStateBtn.setTitle("已進行", for: .normal)
        }
        let theme_3 = UIAction(title: "未進行", image: UIImage(systemName: "pencil")) { _ in
            UIApplication.shared.keyWindow?.showToast(text:"未進行")
            self.orderStateBtn.setTitle("未進行", for: .normal)
        }
        let menu = UIMenu(title: "派工單狀態選擇", children: [theme_1, theme_2, theme_3])
        orderStateBtn.menu = menu
        orderStateBtn.showsMenuAsPrimaryAction = true
        
        let theme2_1 = UIAction(title: "全部", image: UIImage(systemName: "pencil")) { _ in
            UIApplication.shared.keyWindow?.showToast(text:"全部")
            self.orderClassBtn.setTitle("全部", for: .normal)
        }
        let theme2_2 = UIAction(title: "公告事項", image: UIImage(systemName: "pencil")) { _ in
            UIApplication.shared.keyWindow?.showToast(text:"公告事項")
            self.orderClassBtn.setTitle("公告事項", for: .normal)
        }
        let theme2_3 = UIAction(title: "技術通報", image: UIImage(systemName: "pencil")) { _ in
            UIApplication.shared.keyWindow?.showToast(text:"技術通報")
            self.orderClassBtn.setTitle("技術通報", for: .normal)
        }
        let menu2 = UIMenu(title: "派工單類別選擇", children: [theme2_1, theme2_2, theme2_3])
        orderClassBtn.menu = menu2
        orderClassBtn.showsMenuAsPrimaryAction = true
       
    }
}

