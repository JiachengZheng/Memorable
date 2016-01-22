//
//  JCSettingSwitchCell.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/21.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCSettingSwitchCell: JCBaseTableViewCell {
    @IBOutlet weak var swithBtn: UISwitch!
    @IBOutlet weak var title: UILabel!

    override class func identifier() -> String {
        return "\(JCSettingSwitchCell.self)"
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
        guard let object = obj as? JCSettingSwitchItem else{
            return
        }
        swithBtn.on = object.on
        title.text = object.text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        swithBtn.on = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
