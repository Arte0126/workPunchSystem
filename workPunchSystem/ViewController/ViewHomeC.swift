//
//  ViewHomeController.swift
//  workPunchSystem
//
//  Created by 李晉杰 on 2022/7/7.
//

import UIKit

class ViewHomeC: UIViewController {
    let searchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        var titleView = NavigationViewUI().navCreate()
        self.navigationItem.titleView = titleView
    }
    
    

}
