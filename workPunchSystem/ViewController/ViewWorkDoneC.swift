//
//  ViewController.swift
//  workPunchSystem
//
//  Created by 李晉杰 on 2022/7/5.
//

import UIKit

class ViewWorkDoneC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
   
    let searchController = UISearchController()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)as
        UITableViewCell
        cell.imageView?.image=UIImage(systemName: "envelope.fill")
        cell.textLabel?.text = "技術通報"
        cell.detailTextLabel?.text = "系統以維護完備，感謝"
       
        return cell
    }
    internal func tableView(_ tableView:UITableView,trailingSwipeActionsConfigurationForRowAt indexPath:IndexPath)->UISwipeActionsConfiguration?{
        let data = UIContextualAction(style:.normal,title:"進入"){(action, view, completionHandler) in   UIApplication.shared.keyWindow?.showToast(text:"進入派工單...")
            completionHandler(true)
            
        }
        let config = UISwipeActionsConfiguration(actions:[data])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var titleView = NavigationViewUI().navCreate()
        searchController.searchResultsUpdater = self
        navigationItem.titleView?.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = titleView
        self.navigationItem.searchController = searchController//功能還沒寫
    }
}
extension ViewWorkDoneC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
      
        if let searchText:String = searchController.searchBar.text,searchText.isEmpty == false {
        }
        else {
        }
    }
}
