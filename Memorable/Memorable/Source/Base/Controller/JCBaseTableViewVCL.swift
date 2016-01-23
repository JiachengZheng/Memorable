//
//  JCBaseTableViewVCL.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/28.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCBaseTableViewVCL: JCBaseVCL ,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var dataSource =  JCBaseTableViewDataSource(items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (tableView.dataSource is JCBaseTableViewDataSource) {
            let dataSource:JCBaseTableViewDataSource? = tableView.dataSource as? JCBaseTableViewDataSource
            if let d1 = dataSource {
                let object = d1.itemAtIndexPath(indexPath)
                if let obj1 = object {
                    let t1:JCBaseTableViewCell.Type =  d1.tableView(tableView, cellClassForObject: obj1)
                    return t1.tableView(tableView, rowHeightForObject: obj1)
                }
            }
        }
        return 44
    }
}
