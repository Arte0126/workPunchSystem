//
//  MyMenuTableViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 29.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UITableViewController {
    
    private let menuOptionCellId = "Cell"
    var selectedMenuItem : Int = 0
    let sideMenuItem : [String] = ["首頁","代辦單據","未進行單據","已進行單據","全部清單","工單績效","登出"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsets(top: 128.0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        clearsSelectionOnViewWillAppear = false
        
        // Preselect a menu option
        tableView.selectRow(at: IndexPath(row: selectedMenuItem, section: 0), animated: false, scrollPosition: .middle)
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: menuOptionCellId)
        
        if (cell == nil) {
            cell = UITableViewCell(style:.default, reuseIdentifier: menuOptionCellId)
            cell!.backgroundColor = .clear
            cell!.textLabel?.textColor = .darkGray
            let selectedBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
//        cell!.textLabel?.text = "ViewController #\(indexPath.row+1)"
        cell!.textLabel?.text = sideMenuItem[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController?
        switch (indexPath.row) {
        case 0:
            destViewController = R.storyboard.main.viewHomeC()
            break
        case 1:
            destViewController = R.storyboard.main.viewWorkOrderC()
            break
        case 2:
            destViewController = R.storyboard.main.viewWorkDoneC()
            break
        case 3:
            destViewController = R.storyboard.main.viewWorkDoneC()
            break
        case 4:
            destViewController =  R.storyboard.main.viewWorkSelectC()
            break
        case 5:
            destViewController = R.storyboard.main.viewWorkChartC()
            break
        case 6:
            destViewController = R.storyboard.main.viewHomeC()
            break
        default:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController4")
            break
        }
        
        guard let destViewController = destViewController else {
            return
        }
        sideMenuController()?.setContentViewController(destViewController)
       
    }
    
}

