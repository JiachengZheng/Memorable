//
//  JCListTableViewCell.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCListTableViewCell: JCBaseTableViewCell {

    override class func identifier() -> String {
        return "\(JCListTableViewCell.self)"
    }
    
    override func setObject (obj: AnyObject?) {
        super.setObject(obj)
        guard let object = obj as? JCListItem else{
            return
        }
        self.textLabel?.text = "d列表呀"
    }
    
    override func prepareForReuse() {

    }


}
