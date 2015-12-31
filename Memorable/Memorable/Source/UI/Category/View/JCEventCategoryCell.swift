//
//  JCEventCategoryCell.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/30.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCEventCategoryCell: JCBaseTableViewCell {

    @IBOutlet weak var selectImageView: UIImageView!
    override class func identifier() -> String {
        return "\(JCEventCategoryCell.self)"
    }
    
    override func setObject (obj: AnyObject?) {
        super.setObject(obj)
        guard let object = obj as? JCEventCategoryItem else{
            return
        }
        self.textLabel?.text = object.text
        self.textLabel?.font = UIFont.systemFontOfSize(15)
        self.textLabel?.textColor = UIColor.whiteColor()
        selectImageView.hidden = true
        if object.isSelected{
            selectImageView.hidden = false
        }
    }
    
    override func prepareForReuse() {
        self.textLabel?.text = ""
        selectImageView.hidden = true
    }

    
    
    
    
    
    

}
