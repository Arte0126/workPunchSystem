//
//  ViewWorkOrder.swift
//  workPunchSystem
//
//  Created by 李晉杰 on 2022/7/5.
//

import UIKit
import SwiftyJSON
class ViewWorkOrderC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var orderReadState:Bool = false
    var orderTittleList:[String] = ["派工單1","派工單2","派工單3","派工單4","派工單5","派工單6"]
    var orderContentList:[String] =
    ["DP2112210101 異常回報（４能源站","DP2112211104 異常回報（４能源站",
     "DP2112210005 異常回報（４能源站","DP2112210002 異常回報（４能源站",
     "DP2112210003 異常回報（４能源站","DP2112210006 異常回報（４能源站"]
//    var orderReadStateList:[Bool] = [false,false,false,false,false,false]
    var orderImageList:[String] = ["envelope.fill","envelope.fill",
                                   "envelope.fill","envelope.fill",
                                   "envelope.fill","envelope.fill"]
    var filterCount: Int = 0
    var searchClick: Bool = false
    lazy var orderContentFilter = orderContentList
    @IBOutlet weak var orderTableView: UITableView!
    let searchController = UISearchController()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderContentFilter.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)as
        UITableViewCell
        calculateOrderFilter(row: indexPath.row)
        if self.searchClick == true  {
            cell.imageView?.image=UIImage(systemName: orderImageList[filterCount])
        } else {
            cell.imageView?.image=UIImage(systemName: orderImageList[indexPath.row])
        }
        cell.textLabel?.text = orderTittleList[filterCount]
        cell.detailTextLabel?.text = orderContentList[filterCount]
        return cell
    }
    func calculateOrderFilter(row:Int) {
        let orderFilter = orderContentFilter[row]
        for i in (0...orderContentList.count-1) {
            if orderContentList[i] == orderFilter {
                filterCount = i
            }
        }
    }
    internal func tableView(_ tableView:UITableView,trailingSwipeActionsConfigurationForRowAt indexPath:IndexPath)->UISwipeActionsConfiguration?{
        let data = UIContextualAction(style:.normal,title:"進入"){(action, view, completionHandler) in   UIApplication.shared.keyWindow?.showToast(text:"信件已讀")
            self.calculateOrderFilter(row: indexPath.row)
            self.orderImageList[self.filterCount] = "envelope.open.fill"
            self.orderTableView.reloadData()
            completionHandler(true)
          let orderDataReturn =  orderDataReturn(workOrderId: self.orderTittleList[self.filterCount], workOrderState: "read")
            
            var destViewController : UIViewController?
            destViewController = R.storyboard.main.viewWorkPunchC()
            guard let destViewController = destViewController else {
                return
            }
//            self.sideMenuController()?.setContentViewController(destViewController)
//            self.showDetailViewController(destViewController, sender: UIView())
            self.show(destViewController, sender: UIView())
           
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
        self.navigationItem.searchController = searchController
    }
}
extension ViewWorkOrderC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text,
                  searchText.isEmpty == false  {
                    searchClick = true
                    orderContentFilter = orderContentList.filter({ filterResult in
                        filterResult.localizedStandardContains(searchText)
                   })
               } else {
                   searchClick = false
                   orderContentFilter = orderContentList
               }
        print("orderContentFilter")
        print(orderContentFilter.count)
        orderTableView.reloadData()
    }
}
struct orderDataReturn {
    var workOrderId:String
    var workOrderState:String
    init(workOrderId:String,workOrderState:String){
        self.workOrderId = workOrderId
        self.workOrderState = workOrderState
    }
}
