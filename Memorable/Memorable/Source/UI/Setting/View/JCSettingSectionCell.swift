//
//  JCSettingSectionCell.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/21.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCSettingSectionCell: JCBaseTableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override class func identifier() -> String {
        return "\(JCSettingSectionCell.self)"
    }
    
    override class func tableView(tableView: UITableView, rowHeightForObject object: AnyObject) -> CGFloat {
        return 35
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setObject (obj: AnyObject?) {
        super.setObject(obj)
        guard let object = obj as? JCSettingSectionItem else{
            return
        }
        title.text = object.text
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
