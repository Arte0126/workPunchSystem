//
//  ViewErrorList.swift
//  workPunchSystem
//
//  Created by 李晉杰 on 2022/7/6.
//

import UIKit
import DropDown
class ViewErrorListC: UIViewController {

    @IBOutlet weak var DropDownView: UIView!
    @IBOutlet weak var errorTittle: UILabel!
    let dropDown = DropDown()
    let dropDownList = ["aaaa","bbbbb","ccccc","ddddd"]
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.anchorView = DropDownView
        dropDown.dataSource = dropDownList
//        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
//        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.bottomOffset = CGPoint(x: 0, y: 100)
        dropDown.direction = .bottom
    }
    @IBAction func dropDownBtn(_ sender: Any) {
        dropDown.show()
    }
    @IBAction func dropDownBtn2(_ sender: Any) {
        dropDown.show()
    }
}
