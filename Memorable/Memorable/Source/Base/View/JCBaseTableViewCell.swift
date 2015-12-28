//
//  JCBaseTableViewCell.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/28.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCBaseTableViewCell: UITableViewCell {
    
    var item: AnyObject?
    
    class func identifier() -> String {
        return "\(JCBaseTableViewCell.self)"
    }
    
    class func tableView(tableView: UITableView, rowHeightForObject object: AnyObject) -> CGFloat {
        return 44
    }
    
    func setObject (obj: AnyObject?) {
        item = obj
    }

}

