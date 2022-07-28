//
//  NavigationViewUI.swift
//  workPunchSystem
//
//  Created by 李晉杰 on 2022/7/7.
//

import Foundation
import UIKit
class NavigationViewUI: UIViewController {
    func navCreate() -> UIView {
        let rect:CGRect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: 64, height: 64))
        let titleView:UIView = UIView.init(frame: rect)
        /* imageButton */
        let image:UIImage = UIImage.init(systemName: "list.dash")!
        let button = UIButton()
        button.frame = CGRect(x: -115, y: 15, width: 30, height: 30)
        button.setBackgroundImage(image, for: UIControl.State.normal)
        button.addTarget(self, action:#selector(imageButtonTapped), for: .touchUpInside)
//        button.setTitleColor(UIColor.systemGray, for: .highlighted)
//        button.backgroundColor = .gray
        titleView.addSubview(button)
        /* label */
        let label:UILabel = UILabel.init(frame: CGRect.init(x: -15, y: 10, width: 100, height: 40))
        label.text = "ＫＹＭＣＯ"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        titleView.addSubview(label)
        
        let image2:UIImage = UIImage.init(systemName: "exclamationmark.square")!
        let button2 = UIButton()
        button2.frame = CGRect(x: 150, y: 15, width: 30, height: 30)
        button2.setBackgroundImage(image2, for: UIControl.State.normal)
       // button2.addTarget(self, action:#selector(imageButtonTapped), for: .touchUpInside)
        titleView.addSubview(button2)
        return titleView
    }
    @objc func imageButtonTapped(_ sender: Any)
       {
           print("My image button tapped")
       }
}
extension UIButton{
    open override var isHighlighted: Bool{
        didSet {
            backgroundColor = isHighlighted ? UIColor.black : UIColor.lightGray
            layer.borderColor = isHighlighted ? UIColor.green.cgColor : UIColor.yellow.cgColor
        }
    }
}
