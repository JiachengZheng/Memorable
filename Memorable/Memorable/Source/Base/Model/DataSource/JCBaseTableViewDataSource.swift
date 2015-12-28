//
//  JCBaseTableViewDataSource.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/28.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCBaseTableViewDataSource: NSObject,UITableViewDataSource{
    
    var items: [AnyObject]
    
    init(items:[AnyObject]) {
        self.items = items
        super.init()
    }

    func itemAtIndexPath(indexPath: NSIndexPath)-> AnyObject?{
        return items[indexPath.row]
    }
    
    //MARK:  UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(tableView: UITableView, cellClassForObject object: AnyObject) -> JCBaseTableViewCell.Type {
        return JCBaseTableViewCell.self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell:UITableViewCell
        
        let object = itemAtIndexPath(indexPath)
        
        if let obj = object{
            
            let cellClass: JCBaseTableViewCell.Type = self.tableView(tableView, cellClassForObject: obj)
            
            let identifier: String = cellClass.identifier()
            var cell1: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier)
            if cell1 == nil {
                cell1 = JCBaseTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            }
            cell = cell1!
        }else{
            cell = JCBaseTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        }
        if let cell1 = cell as? JCBaseTableViewCell {
            cell1.setObject(object)
        }
        return cell
    }
    
}
