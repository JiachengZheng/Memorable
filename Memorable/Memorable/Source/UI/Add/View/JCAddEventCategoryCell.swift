//
//  JCAddEventCategoryCell.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/23.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCAddEventCategoryCell: JCBaseTableViewCell {

    override class func identifier() -> String {
        return "\(JCAddEventCategoryCell.self)"
    }
    
    override class func tableView(tableView: UITableView, rowHeightForObject object: AnyObject) -> CGFloat {
        return 50
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let line = CALayer()
        line.frame = CGRectMake(8, 44 - 0.5, screenWidth, 0.5)
        self.layer.addSublayer(line)
        line.backgroundColor = ColorSeparator().CGColor
    }
    
    override func setObject (obj: AnyObject?) {
        super.setObject(obj)
        guard let object = obj as? JCAddEventCategoryItem else{
            return
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }


}
