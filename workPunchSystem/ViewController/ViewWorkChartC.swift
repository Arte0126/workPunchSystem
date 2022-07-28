//
//  ViewWorkChartC.swift
//  workPunchSystem
//
//  Created by 李晉杰 on 2022/7/11.
//

import UIKit
import MSBBarChart

class ViewWorkChartC: UIViewController {
    @IBOutlet weak var barChart: MSBBarChartView!
//    @IBOutlet weak var barChart2: MSBBarChartView!
    
    @IBOutlet weak var pickMonthBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var titleView = NavigationViewUI().navCreate()
        self.navigationItem.titleView = titleView
        themeMenu()
        pickMonthBtn.setTitle("請選擇", for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.barChart.setOptions([.yAxisTitle("單數"), .yAxisNumberOfInterval(10),])
        self.barChart.assignmentOfColor =  [0.0..<0.14: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), 0.14..<0.28: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), 0.28..<0.42: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), 0.42..<0.56: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), 0.56..<0.70: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), 0.70..<1.0: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]
        self.barChart.setDataEntries(values: [12,24,36,48,60])
        self.barChart.setXAxisUnitTitles(["高雄","台南","台中","桃園","雙北"])
        self.barChart.start()
        
//        self.barChart2.setOptions([.yAxisTitle("売上"), .xAxisUnitLabel("月")])
//        self.barChart2.assignmentOfColor =  [0.0..<0.14: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), 0.14..<0.28: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), 0.28..<0.42: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), 0.42..<0.56: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), 0.56..<0.70: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), 0.70..<1.0: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
//        self.barChart2.setDataEntries(values: [16,32,64,128,256,512,1024,2048])
//        self.barChart2.start()
    }
    func themeMenu() {//下拉選單
        let theme_1 = UIAction(title: "一月", image: UIImage(systemName: "pencil")) { _ in
            UIApplication.shared.keyWindow?.showToast(text:"一月")
            self.pickMonthBtn.setTitle("一月", for: .normal)
        }
        let theme_2 = UIAction(title: "二月", image: UIImage(systemName: "pencil")) { _ in
            UIApplication.shared.keyWindow?.showToast(text:"二月")
            self.pickMonthBtn.setTitle("二月", for: .normal)
        }
        let theme_3 = UIAction(title: "三月", image: UIImage(systemName: "pencil")) { _ in
            UIApplication.shared.keyWindow?.showToast(text:"三月")
            self.pickMonthBtn.setTitle("三月", for: .normal)
        }
        let menu = UIMenu(title: "月份選擇", children: [theme_1, theme_2, theme_3])
        pickMonthBtn.menu = menu
        pickMonthBtn.showsMenuAsPrimaryAction = true
    }
}

    

    

