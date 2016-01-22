//
//  JCSettingSelectCell.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/21.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCSettingSelectCell: JCBaseTableViewCell {
    @IBOutlet weak var rightTitle: UILabel!

    @IBOutlet weak var title: UILabel!
    override class func identifier() -> String {
        return "\(JCSettingSelectCell.self)"
    }
    
    override class func tableView(tableView: UITableView, rowHeightForObject object: AnyObject) -> CGFloat {
        return 44
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
        guard let object = obj as? JCSettingSelectItem else{
            return
        }
        title.text = object.title
        rightTitle.text = object.detail
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        rightTitle.text = ""
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
